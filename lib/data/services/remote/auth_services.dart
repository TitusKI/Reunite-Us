import 'package:afalagi/core/constants/constant.dart';
import 'package:afalagi/domain/entities/auth/user_entity.dart';
import 'package:afalagi/data/services/local/storage_services.dart';
import 'package:afalagi/presentation/views/common/widgets/flutter_toast.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthServices {
  final StorageService storageService;
  final Dio _dio = Dio(BaseOptions(
    baseUrl: AppConstant.BASE_URL,
    headers: {'Content-Type': 'application/json'},
  ));
//  AuthServices(this.storageService);

  AuthServices(this.storageService) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          print("Request starting ...");
          // List of paths that need headers
          const pathsWithHeaders = [
            '/auth/logout',
            '/auth/verify-email',
            '/auth/refresh',
            '/auth/reset-password',
            '/auth/forgot-password',
            '/auth/verify-email/resend',

            // '/user/profile',
            // '/auth/google/signin',
            // Add other paths that need headers here
          ];

          if (pathsWithHeaders.contains(options.path)) {
            print("Path with Header for access Token");
            final accessToken = await storageService.getAccessToken();
            if (accessToken != null) {
              options.headers['Authorization'] = 'Bearer $accessToken';
              print("Access Token with The same path headers");
              print(accessToken);
            }
          }
          return handler.next(options);
        },
        onError: (DioException error, handler) async {
          // Check if the error is due to an expired access token
          if (error.response?.statusCode == 401 &&
              error.requestOptions.path != "/auth/refresh") {
            // Attempt to refresh the token
            try {
              final newAccessToken = await refreshToken();
              // Update the header with the new access token
              error.requestOptions.headers['Authorization'] =
                  'Bearer $newAccessToken';
              // Retry the failed request with the new access token
              final response = await _dio.request(
                error.requestOptions.path,
                options: Options(
                  method: error.requestOptions.method,
                  headers: error.requestOptions.headers,
                ),
                data: error.requestOptions.data,
                queryParameters: error.requestOptions.queryParameters,
              );
              return handler.resolve(response);
            } catch (e) {
              // If token refresh fails, forward the error
              return handler.next(error);
            }
          }
          return handler.next(error);
        },
      ),
    );
  }
  Future<void> signin(String? email, String? password) async {
    // storageService.clearTokens();
    try {
      final response = await _dio.post("/auth/local/signin", data: {
        "email": email,
        "password": password,
      });
      final data = response.data;
      if (data == null || data['access_token'] == null) {
        throw Exception('Sign-in failed: No access token received.');
      }
      await storageService.storeToken(
          accessToken: data['access_token'],
          refreshToken: data['refresh_token']);
      print("Sign-in successful: $data");
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.message}');
        if (e.response != null) {
          print('Error response: ${e.response?.data}');
          // throw Exception('Sign-in failed: ${e.response?.data['message']}');
          toastInfo(msg: "${e.response?.data['message']}");
        }

        throw Exception('Sign-in failed: ${e.message}');
      } else {
        print('Unexpected error: $e');
        throw Exception('Unexpected error: $e');
      }
    }
  }

  final GoogleSignIn _googleSignIn = GoogleSignIn(
    scopes: [
      'email',
      'https://www.googleapis.com/auth/contacts.readonly',
      // 'profile',
    ],
  );

  Future<void> signinGoogle() async {
    try {
      print("Started Google Sign-In");

      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser == null) {
        print("No user found");
        // The user canceled the sign-in
        return;
      }

      // final GoogleSignInAuthentication googleAuth =
      //     await googleUser.authentication;

      // Use the ID token to authenticate with your server

      // final idToken = googleAuth.idToken;
      // final accessToken = googleAuth.accessToken;

      // Make an API call to your backend to sign in
      final dio = Dio();
      final response = await dio.get(
        "${AppConstant.BASE_URL}/auth/google/android/login",
// home
        // "http://192.168.100.13:3333/api/auth/google/android/login",
// ewnet
        // "http://192.168.100.186:3333/api/auth/google/android/login",
        // data: {"id_token": idToken},
      );

      if (response.statusCode == 200) {
        final responseData = response.data;
        await storageService.storeToken(
          accessToken: responseData['access_token'],
          refreshToken: responseData['refresh_token'],
        );
        print("Google Sign-In successful: $responseData");
      } else {
        print("Google Sign-In failed: ${response.data}");
      }
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.message}');
        if (e.response != null) {
          print('Error response: ${e.response?.data}');
          throw Exception(
              'Google Sign-In failed: ${e.response?.data['message']}');
        }
        throw Exception('Google Sign-In failed: ${e.message}');
      } else {
        print('Unexpected error: $e');
        throw Exception('Unexpected error: $e');
      }
    }
  }

  Future<void> handleGoogleRedirect() async {
    try {
      final dio = Dio();
      final response = await dio.get(
          //chrome
          "${AppConstant.BASE_URL}/auth/google/android/redirect");
      //home
      // "http://192.168.100.13:3333/api/auth/google/android/redirect");
      // ewnet
      // "http://192.168.43.184:3333/api/auth/google/android/redirect");

      if (response.statusCode == 200) {
        final data = response.data;
        await storageService.storeToken(
          accessToken: data['access_token'],
          refreshToken: data['refresh_token'],
        );
        print("Google Sign-Up successful: $data");
      } else {
        print("Google Sign-Up failed: ${response.data}");
      }
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.message}');
        if (e.response != null) {
          print('Error response: ${e.response?.data}');
          throw Exception(
              'Google Sign-Up failed: ${e.response?.data['message']}');
        }
        throw Exception('Google Sign-Up failed: ${e.message}');
      } else {
        print('Unexpected error: $e');
        throw Exception('Unexpected error: $e');
      }
    }
  }

  // Future<void> signinGoogle() async {
  //   try {
  //     print("started google");

  //     final response = await _dio.get("/auth/google/android/login");
  //     if (response.data.toString().contains('<!doctype html')) {
  //       final loginUrl = response.realUri;
  //       print('Redirecting to Google Sign-In-Url: $loginUrl');
  //       if (await canLaunchUrl(loginUrl)) {
  //         await launchUrl(loginUrl);
  //       } else {
  //         throw Exception('Could not launch Google Sign-In URL');
  //       }
  //     } else {
  //       final responseData = jsonDecode(response.data);
  //       print(responseData);
  //       print("Google Sign-In initiated: ${response.data}");
  //     }
  //   } catch (e) {
  //     if (e is DioException) {
  //       print('DioException: ${e.message}');
  //       if (e.response != null) {
  //         print('Error response: ${e.response?.data}');
  //         throw Exception(
  //             'Google Sign-In failed: ${e.response?.data['message']}');
  //       }
  //       throw Exception('Google Sign-In failed: ${e.message}');
  //     } else {
  //       print('Unexpected error: $e');
  //       throw Exception('Unexpected error: $e');
  //     }
  //   }
  // }

  // Google Sign-Up method
  // Future<void> handleGoogleRedirect() async {
  //   try {
  //     final response = await _dio.get("/auth/google/android/redirect");
  //     final data = response.data;
  //     await storageService.storeToken(
  //         accessToken: data['access_token'],
  //         refreshToken: data['refresh_token']);
  //     print("Google Sign-Up successful: $data");
  //   } catch (e) {
  //     if (e is DioException) {
  //       print('DioException: ${e.message}');
  //       if (e.response != null) {
  //         print('Error response: ${e.response?.data}');
  //         throw Exception(
  //             'Google Sign-Up failed: ${e.response?.data['message']}');
  //       }
  //       throw Exception('Google Sign-Up failed: ${e.message}');
  //     } else {
  //       print('Unexpected error: $e');
  //       throw Exception('Unexpected error: $e');
  //     }
  //   }
  // }

  Future<void> signup(User user) async {
    storageService.clearTokens();
    try {
      final response = await _dio.post(
        "/auth/local/signup",
        data: user.toJson(),
      );

      final data = response.data;
      await storageService.storeToken(
          accessToken: data['access_token'],
          refreshToken: data['refresh_token']);
      print("From Api response: $data");
      final getToken = await storageService.getAccessToken();
      print("Access Token is :$getToken");
    } catch (e) {
      print("Error cached $e");
      throw Exception(e.toString());
    }
  }

  Future<void> forgotPassword(String email) async {
    try {
      final response = await _dio.post("/auth/forgot-password", data: {
        "email": email,
      });
      final data = response.data;
      print("Reset Token from api is: ");
      print(data["resetToken"]);

      await storageService.storeToken(
        resetToken: data["resetToken"],
      );
      print("From Api response: $data");
      final getToken = await storageService.getResetToken();
      print("Reset Token is :$getToken");
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.message}');
        if (e.response != null) {
          print('Error response: ${e.response?.data}');
        }
      } else {
        print('Unexpected error: $e');
      }
    }
  }

  Future<void> verifyCode(String email, int code) async {
    try {
      final response = await _dio.post(
        "/auth/verify-email",
        data: {'email': email, 'verificationCode': code},
      );

      print('Verification successful: ${response.data["message"]}');
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.message}');
        if (e.response != null) {
          print('Error response: ${e.response?.data}');
        }
      } else {
        print('Unexpected error: $e');
      }
    }
  }

  Future<String> refreshToken() async {
    // storageService.clearTokens();
    final refreshToken = await storageService.getRefreshToken();
    if (refreshToken == null) {
      throw Exception("No refresh token available");
    }
    try {
      final response = await _dio.post(
        "/auth/refresh",
        data: {
          'refresh_token': refreshToken,
        },
      );

      final data = response.data;
      await storageService.storeToken(
          accessToken: data['access_token'],
          refreshToken: data['refresh_token']);
      final getAccessToken = await storageService.getAccessToken();
      return getAccessToken!;
    } catch (e) {
      print(e);
      throw Exception("Failed to refresh token: ${e.toString()}");
    }
  }

  Future<void> resetPassword(String newPassword, String confirmPassword) async {
    final getResetToken = await storageService.getResetToken();
    try {
      final response =
          await _dio.post("/auth/reset-password", queryParameters: {
        'resetToken': getResetToken,
      }, data: {
        "password": newPassword,
        // "passwordConfirm": confirmPassword,
      });
      final data = response.data;
      await storageService.storeToken(
          accessToken: data['access_token'],
          refreshToken: data['refresh_token']);
      print("From Api response: $data");
      final getToken = await storageService.getAccessToken();
      print("Access Token after newPassword is  :$getToken");
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  Future<void> signOut() async {
    // final accessToken = await storageService.getAccessToken();
    try {
      await _dio.post(
        "/auth/logout",
        // options: Options(headers: {'Authorization': "Bearer $accessToken"}),
      );
      storageService.clearTokens();

      print("Successfully Signed out: true");
    } catch (e) {
      print(e.toString());
    }
  }

  Future<void> resendCode(String email) async {
    try {
      final response = await _dio.post("/auth/verify-email/resend",
          //options: Options(headers: {}),
          data: {
            'email': email,
          });
      print('Verification email resent: ${response.data}');
    } catch (e) {
      if (e is DioException) {
        print('DioException: ${e.message}');
        if (e.response != null) {
          print('Error response: ${e.response?.data}');
        }
      } else {
        print('Unexpected error: $e');
      }
    }
  }
}
