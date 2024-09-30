import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'package:afalagi/core/constants/constant.dart';
import 'package:afalagi/features/user/data/models/user_profile_model.dart';

import 'package:afalagi/injection_container.dart';
import 'package:dio/dio.dart';

import '../../../../core/constants/data_export.dart';
import '../../domain/entities/user_profile_entity.dart';

class UserServices {
  final Dio _dio = Dio(BaseOptions(
    baseUrl: AppConstant.BASE_URL,
    headers: {'Content-Type': 'application/json'},
  ));

  UserServices() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          print("Request starting ...");
          // List of paths that need headers
          const pathsWithHeaders = [
            // '/auth/logout',
            // '/auth/verify-email',
            '/auth/refresh',
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
            final accessToken = await sl<StorageService>().getAccessToken();
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
              final newAccessToken = await sl<AuthServices>().refreshToken();
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
  Completer? _refreshCompleter;

  Future<String> refreshToken() async {
    if (_refreshCompleter != null) {
      await _refreshCompleter!.future;
    } else {
      _refreshCompleter = Completer();

      try {
        final response = await _dio.post(
          "/auth/refresh",
          data: {'refresh_token': refreshToken},
        );

        final data = response.data;
        await sl<StorageService>().storeToken(
          accessToken: data['access_token'],
          refreshToken: data['refresh_token'],
        );

        _refreshCompleter!.complete();
      } catch (e) {
        _refreshCompleter!.completeError(e);
        rethrow;
      } finally {
        _refreshCompleter = null;
      }
    }

    return await sl<StorageService>().getAccessToken() ?? "";
  }

  Future<void> buildUserProfile({
    required UserProfileEntity userProfile,
  }) async {
    try {
      // final accessToken = await sl<StorageService>().getAccessToken();
      // print("Access Token for: $accessToken");

      // Authorization header
      // var headers = {
      //   'Authorization': 'Bearer $accessToken',
      // };

      print("Profile start to build in dio");

      // var dio = Dio();
      final UserProfile profileModel = UserProfile.fromEntity(userProfile);
      print(profileModel.toJson());

      // Create the FormData
      FormData data = profileModel.toFormData();
      print(data);
      print(data.fields);
      print(data.files);

      // Send the request
      var response = await _dio.post(
        "/user/profile",
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
