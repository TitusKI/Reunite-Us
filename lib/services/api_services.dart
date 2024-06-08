import 'dart:convert';
import 'dart:io';

import 'package:afalagi/model/missing_person.dart';
import 'package:afalagi/model/user_model.dart';
import 'package:afalagi/model/user_profile_model.dart';
import 'package:afalagi/services/storage_services.dart';
import 'package:afalagi/views/common/widgets/flutter_toast.dart';
import 'package:dio/dio.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

class ApiServices {
  final StorageService storageService;
  final Dio _dio = Dio(BaseOptions(
    // Ewenet
    // baseUrl: "http://192.168.100.186:3333/api",
// home
    baseUrl: "http://192.168.100.13:3333/api",
    // baseUrl: "http://127.0.0.1:3333/api",
    headers: {'Content-Type': 'application/json'},
  ));
//  ApiServices(this.storageService);

  ApiServices(this.storageService) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          print("Request starting ...");
          // List of paths that need headers
          const pathsWithHeaders = [
            '/auth/logout',
            '/auth/verify-email',
            '/user/profile/me',
            // '/user/profile',
            '/user/profile/pic',
            '/post',
            '/post/me',

            // '/user/profile',
            // '/auth/google/signin',
            // Add other paths that need headers here
          ];

          if (pathsWithHeaders.contains(options.path)) {
            print("Path with Header for access Token");
            final accessToken = await storageService.getAccessToken();
            if (accessToken != null) {
              options.headers['Authorization'] = 'Bearer $accessToken';
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
  Future<void> signin(String email, String password) async {
    storageService.clearTokens();
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

      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      // Use the ID token to authenticate with your server

      final idToken = googleAuth.idToken;
      final accessToken = googleAuth.accessToken;

      // Make an API call to your backend to sign in
      final dio = Dio();
      final response = await dio.get(
        // "http://127.0.0.1:3333/api/auth/google/android/login",
// home
        // "http://192.168.100.13:3333/api/auth/google/android/login",
// ewnet
        "http://192.168.100.186:3333/api/auth/google/android/login",
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
          // "http://127.0.0.1:3333/api/auth/google/android/redirect",
          //home
          // "http://192.168.100.13:3333/api/auth/google/android/redirect");
          // ewnet
          "http://192.168.100.186:3333/api/auth/google/android/redirect");

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

  Future<FormData> createProfileFormData(
      UserProfile userProfile, File file) async {
    print("Started in form Data");
    print("All profile information");
    print(userProfile.firstName);
    print(userProfile.middleName);

    print(userProfile.lastName);

    print(userProfile.gender);

    print(userProfile.phoneNumber.toString());

    print(userProfile.birthDate);
    print(userProfile.country);
    print(userProfile.state);
    print(userProfile.city);
    print(file);
    final Map<String, dynamic> userProfileMap = userProfile.toJson();
    final formDataMap = {
      ...userProfileMap,
      'profilePicture': [
        await MultipartFile.fromFile(file.path, filename: "profile_picture.png")
      ],
    };
    final FormData formData = FormData.fromMap(formDataMap);
    // final FormData formData = FormData.fromMap(

    return formData;
  }

  Future<void> buildUserProfile(
      {required UserProfile userProfile, required File file}) async {
    final accessToken = await storageService.getAccessToken();
    print("Access Token for: $accessToken");
    var headers = {
      'Authorization': 'Bearer $accessToken', // Replace with your access token
    };
    print("Profile start to build in dio ");
    var dio = Dio();
    var data = await createProfileFormData(userProfile, file);
    var response = await dio.request(
      "http://192.168.100.186:3333/api/user/profile",

      // "http://192.168.100.13:3333/api/user/profile",
      // "http://127.0.0.1:3333/api/user/profile",
      options: Options(
        method: 'POST',
        headers: headers,
        contentType: 'multipart/form-data',
      ),
      data: data,
    );
    // final Dio profileDio = Dio(BaseOptions(
    //   baseUrl: "http://192.168.100.13:3333/api",
    //   // baseUrl: "http://127.0.0.1:3333/api",
    //   headers: {'Content-Type': 'multiPart/form-data'},
    // ));

    // var response = await _dio.post(
    //   "/user/profile",
    //   data: data,
    // );
    if (response.statusCode == 200) {
      print(json.encode(response.data));
    } else {
      print(response.statusMessage);
    }
  }

  Future<UserProfile> getMyProfile() async {
    final response = await _dio.get(
      '/user/profile/me',
    );

    if (response.statusCode == 200) {
      final data = response.data['data'];
      return UserProfile.fromJson(data);
    } else {
      throw Exception('Failed to load profile');
    }
  }

  Future<UserProfile> updateUserProfile(Map<String, dynamic> updates) async {
    final response = await _dio.patch(
      '/user/profile',
      data: updates,
    );

    if (response.statusCode == 200) {
      final data = response.data['data'];
      return UserProfile.fromJson(data);
    } else {
      throw Exception('Failed to update profile');
    }
  }

  Future<Response> getProfilePicture(String token) async {
    final response = await _dio.get(
      '/user/profile/pic',
      options: Options(
        responseType: ResponseType.stream,
      ),
    );

    if (response.statusCode == 200) {
      return response;
    } else {
      throw Exception('Failed to load profile picture');
    }
  }

  Future<void> deleteProfilePicture() async {
    final response = await _dio.delete(
      '/user/profile/pic',
    );

    if (response.statusCode == 200) {
      final data = response.data;
      if (data['status'] != 'success') {
        throw Exception('Failed to delete profile picture');
      }
    } else {
      throw Exception('Failed to delete profile picture');
    }
  }

  Future<UserProfile> updateProfilePicture(FormData formData) async {
    final response = await _dio.patch(
      '/user/profile/pic',
      data: formData,
    );

    if (response.statusCode == 200) {
      final data = response.data['data'];
      return UserProfile.fromJson(data);
    } else {
      throw Exception('Failed to update profile picture');
    }
  }

  Future<MissingPerson> createPost(MissingPerson post, XFile postImages,
      XFile legalDocs, List<MultipartFile?>? videoMessage) async {
    final Map<String, dynamic> missingInfo = post.toJson();
    final formData = {
      ...missingInfo,
      'postImages': await MultipartFile.fromFile(postImages.path,
          filename: postImages.name),
      'legalDocs': await MultipartFile.fromFile(legalDocs.path,
          filename: legalDocs.name),
    };
    final response = await _dio.post(
      '/post',
      data: formData,
    );

    if (response.statusCode == 200) {
      return MissingPerson.fromJson(response.data['data']);
    } else {
      throw Exception('Failed to create post');
    }
  }

  Future<PostResponse> getMyPosts() async {
    final response = await _dio.get(
      '/post/me',
    );

    if (response.statusCode == 200) {
      return PostResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<PostResponse> getAllPosts() async {
    final response = await _dio.get('/post');
    if (response.statusCode == 200) {
      return PostResponse.fromJson(response.data);
    } else {
      throw Exception('Failed to load all posts');
    }
  }
}
