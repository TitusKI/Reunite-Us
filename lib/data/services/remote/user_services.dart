import 'dart:convert';
import 'dart:io';
import 'package:afalagi/core/constants/constant.dart';
import 'package:afalagi/core/constants/domain_export.dart';
import 'package:afalagi/data/models/Auth/user_profile_model.dart';
import 'package:afalagi/data/services/local/storage_services.dart';
import 'package:afalagi/injection_container.dart';
import 'package:dio/dio.dart';

class UserServices {
  final StorageService storageService;
  final Dio _dio = Dio(BaseOptions(
    baseUrl: AppConstant.BASE_URL,
    headers: {'Content-Type': 'application/json'},
  ));
//  UserServices(this.storageService);

  UserServices(this.storageService) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          print("Request starting ...");
          // List of paths that need headers
          const pathsWithHeaders = [
            // '/auth/logout',
            // '/auth/verify-email',
            '/user/profile/me',
            '/user/profile',
            '/user/profile/pic',
            // '/post',
            // '/post/me',

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
              final newAccessToken = await sl<AuthRepository>().refreshToken();
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

  // Future<String> refreshToken() async {
  //   // storageService.clearTokens();
  //   final refreshToken = await storageService.getRefreshToken();
  //   if (refreshToken == null) {
  //     throw Exception("No refresh token available");
  //   }
  //   try {
  //     final response = await _dio.post(
  //       "/auth/refresh",
  //       data: {
  //         'refresh_token': refreshToken,
  //       },
  //     );

  //     final data = response.data;
  //     await storageService.storeToken(
  //         accessToken: data['access_token'],
  //         refreshToken: data['refresh_token']);
  //     final getAccessToken = await storageService.getAccessToken();
  //     return getAccessToken!;
  //   } catch (e) {
  //     print(e);
  //     throw Exception("Failed to refresh token: ${e.toString()}");
  //   }
  // }

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

    // Fix: Correct the profilePicture part
    final formDataMap = {
      ...userProfileMap,
      'profilePicture': await MultipartFile.fromFile(file.path,
          filename: "profile_picture.png"),
    };

    final FormData formData = FormData.fromMap(formDataMap);

    return formData;
  }

  Future<void> buildUserProfile({
    required UserProfile userProfile,
    required File file,
  }) async {
    try {
      final accessToken = await storageService.getAccessToken();
      print("Access Token for: $accessToken");

      // Authorization header
      var headers = {
        'Authorization': 'Bearer $accessToken',
      };

      print("Profile start to build in dio");

      var dio = Dio();

      // Create the FormData
      var data = await createProfileFormData(userProfile, file);

      // Send the request
      var response = await dio.post(
        "${AppConstant.BASE_URL}/user/profile",
        // "http://192.168.43.184:3333/api/user/profile",
        options: Options(
          headers: headers,
          contentType: 'multipart/form-data',
        ),
        data: data,
      );

      // Check for response status
      if (response.statusCode == 200 || response.statusCode == 201) {
        print("Profile created successfully");
        print(json.encode(response.data));
      } else {
        print("Error: ${response.statusCode}, ${response.statusMessage}");
      }
    } catch (e) {
      // Catch and print the DioError or any other exception
      if (e is DioException) {
        print("Dio error: ${e.response?.statusCode} - ${e.response?.data}");
      } else {
        print("Error occurred: $e");
      }
    }
  }

  Future<UserProfile> getMyProfile() async {
    final response = await _dio.get(
      '/user/profile/me',
    );

    if (response.statusCode == 200) {
      final data = response.data['data'];
      print(UserProfile.fromJson(data));
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

  Future<Response> getProfilePicture() async {
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

  Future<File?> updateProfilePicture(FormData formData) async {
    final response = await _dio.patch(
      '/user/profile/pic',
      data: formData,
    );

    if (response.statusCode == 200) {
      print("Update Profile Picture");
      final data = response.data['data'];
      print(data);
      UserProfile.fromJson(data);
    } else {
      throw Exception('Failed to update profile picture');
    }
    return null;
  }
}
