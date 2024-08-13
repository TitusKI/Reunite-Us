import 'package:afalagi/core/constants/constant.dart';
import 'package:afalagi/core/constants/data_export.dart';
import 'package:afalagi/core/constants/domain_export.dart';

import 'package:afalagi/injection_container.dart';
import 'package:dio/dio.dart';

class PostServices {
  final StorageService storageService;
  final Dio _dio = Dio(BaseOptions(
    baseUrl: AppConstant.BASE_URL,
    headers: {'Content-Type': 'application/json'},
  ));
//  PostServices(this.storageService);

  PostServices(this.storageService) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          print("Request starting ...");
          // List of paths that need headers
          const pathsWithHeaders = [
            '/auth/refresh',
          ];
          const String post = "/post";

          if (pathsWithHeaders.contains(options.path) ||
              (options.path.startsWith(post))) {
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

  Future<void> createPost(MissingPersonEntity missingPerson) async {
    try {
      MissingPerson missingInfo = MissingPerson.fromEntity(missingPerson);
      final formData = {
        ...missingInfo.toJson(),
        // Test on this post image toList and multipartfile format
        // How to send more than one missng person photo and document
        'postImages': await MultipartFile.fromFile(
          missingPerson.postImages.toList().toString(),
          filename: 'post_image.jpg',
        ),
        'legalDocs': await MultipartFile.fromFile(
            missingPerson.legalDocs.toList().toString(),
            filename: 'legal_docs.jpg'),
      };
      final response = await _dio.post(
        '/post',
        data: formData,
      );

      if (response.statusCode != 200) {
        throw Exception('Failed To Post Missing Person');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<List<MissingPersonEntity>> getMyPosts() async {
    final response = await _dio.get(
      '/post/me',
    );

    if (response.statusCode == 200) {
      // parse response into a list of MissingPersonModel
      final List<MissingPerson> missingPersonModel = (response.data as List)
          .map((json) => MissingPerson.fromJson(json))
          .toList();
// convert Models to Entities
      return missingPersonModel
          .map((missingPersonModel) => missingPersonModel.toEntity())
          .toList();
    } else {
      throw Exception('Failed to load posts');
    }
  }

  Future<List<MissingPersonEntity>> getAllPosts() async {
    final response = await _dio.get('/post');
    if (response.statusCode == 200) {
      print("THIS IS THE RESPONSE FOR GET ALL POSTS ");
      // print(response.data['data']);
      // parse a response into a list of Missing Person mOdel
      final List<MissingPerson> missingPersonModel =
          (response.data['data'] as List)
              .map((json) => MissingPerson.fromJson(json))
              .toList();
      print(missingPersonModel[0].maritalStatus);
      // convert models into Entity
      print("Posts data ");
      print(missingPersonModel);
      final List<MissingPersonEntity> missingPersons = missingPersonModel
          .map((missingPersonModel) => missingPersonModel.toEntity())
          .toList();
      print("To Entity");
      print(missingPersons);
      return missingPersons;
    } else {
      throw Exception('Failed to load all posts');
    }
  }

  Future<void> closePost(ClosedCaseEntity update) async {
    // what other data must be updates with the close case
    try {
      Response response = await _dio.patch(
        '/post/close/${update.id}',
        data: update,
      );

      if (response.statusCode == 200) {
        final closeCaseID = response.data['data']['id'];
        storageService.storeId(closeCaseId: closeCaseID);
        print("Post closed successfuly");
      } else {
        throw Exception("Failed to Close The Case");
      }
    } on DioException catch (e) {
      print(e.toString());
    }
  }

  Future<void> deletePost(String id) async {
    try {
      final response = await _dio.delete('/post/$id');
      if (response.statusCode == 200) {
        print('Delete Posts');
        print(response.data);
      } else {
        throw Exception("Failed to Close The Case");
      }
    } on DioException catch (e) {
      print(e.toString());
    }
  }

  Future<void> editPostById(UpdatePostEntity updatePostEntity) async {
    try {
      final response = await _dio.patch(
        '/post/${updatePostEntity.id}',
        data: updatePostEntity.updates,
      );
      if (response.statusCode == 200) {
        print("Post updated successfully");
      } else {
        throw Exception("Failed to Close The Case");
      }
    } on DioException catch (e) {
      print(e.toString());
    }
  }

  Future<MissingPersonEntity> getPostById(String id) async {
    try {
      final response = await _dio.patch('/post/$id');
      _dio.interceptors.add(InterceptorsWrapper(
        onRequest: (options, handler) async {
          print("Request starting ...");
          // List of paths that need headers
          final pathsWithHeaders = [
            '/post/$id',

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
      ));
      if (response.statusCode == 200) {
        final MissingPerson missingPersonModel =
            MissingPerson.fromJson(response.data);
        return missingPersonModel.toEntity();
      } else {
        throw Exception("Failed to Close The Case");
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<PostDocsEntity> getPostDocs(String postId) async {
    try {
      // Perform the GET request for docs
      final response = await _dio.get('/post/$postId/docs');

      if (response.statusCode == 200) {
        // Parse the response and return the PostDocsEntity
        return PostDocsModel.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load post documents');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }

  Future<PostImagesEntity> getPostImages(String postId) async {
    try {
      // Perform the GET request
      final response = await _dio.get('/post/$postId/images');

      if (response.statusCode == 200) {
        // Parse the response and return the PostImagesEntity
        return PostImagesModel.fromJson(response.data['data']);
      } else {
        throw Exception('Failed to load post images');
      }
    } catch (e) {
      throw Exception(e.toString());
    }
  }
}
