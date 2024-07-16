import 'package:afalagi/services/storage_services.dart';
import 'package:dio/dio.dart';

class ApiServices {
  final StorageService storageService;
  final Dio _dio = Dio(BaseOptions(
    baseUrl: "http://192.168.100.186:3333/api",
    headers: {'Content-Type': 'application/json'},
  ));
  ApiServices(this.storageService) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final accessToken = await storageService.getAccessToken();
          if (accessToken != null) {
            options.headers['Authorization'] = 'Bearer $accessToken';
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
  Future<void> signup(
      String email, String password, String passwordConfirm) async {
    try {
      final response = await _dio.post(
        "/auth/local/signup",
        data: {
          'email': email,
          'password': password,
          'passwordConfirm': passwordConfirm,
        },
      );

      final data = response.data;
      await storageService.storeToken(
          data['access_token'], data['refresh_token']);
      print("From Api response: $data");
      final getToken = await storageService.getAccessToken();
      print("Access Token is :$getToken");
    } catch (e) {
      print(e);
      throw Exception(e.toString());
    }
  }

  Future<void> verifyCode(String email, String code) async {
    try {
      final response = await _dio.post(
        "/auth/verify-email",
        data: {'email': email, 'code': code},
      );

      print('Verification successful: ${response.data}');
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
          data['access_token'], data['refresh_token']);
      return data['access_token'];
    } catch (e) {
      print(e);
      throw Exception("Failed to refresh token: ${e.toString()}");
    }
  }

  Future<void> resendCode(String email) async {
    try {
      final response = await _dio.post("/auth/verify-email/resend", data: {
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
