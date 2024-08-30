import 'package:afalagi/core/constants/constant.dart';
import 'package:afalagi/core/error/failure.dart';
import 'package:afalagi/data/models/success_story/success_story_model.dart';
import 'package:afalagi/data/services/local/storage_services.dart';
import 'package:afalagi/domain/entities/success_story/success_story_entity.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

class SuccessStoryServices {
  final StorageService storageService;
  final Dio _dio = Dio(BaseOptions(
    baseUrl: AppConstant.BASE_URL,
    headers: {'Content-Type': 'application/json'},
  ));
//  SuccessStoryServices(this.storageService);

  SuccessStoryServices(this.storageService) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          print("Request starting ...");
          // List of paths that need headers
          // const pathsWithHeaders = [
          //   '/success-story',
          // ];
          // if (pathsWithHeaders.contains(options.path))
          if (options.path.startsWith('/success-story')) {
            print("Path with Header for access Token");
            final accessToken = await storageService.getAccessToken();
            if (accessToken != null) {
              options.headers['Authorization'] = 'Bearer $accessToken';
              print("Access Token with The same path headers");
              print(accessToken);
            }
            // return handler.next(options);
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

  Future<Either<Failure, void>> createSuccessStory(
      SuccessStoryEntity successStory) async {
    try {
      SuccessStoryModel successStoryinfo =
          SuccessStoryModel.fromEntity(successStory);
      final data = successStoryinfo.toJson();
      final formData = {
        ...data,
        // WHY
        //The images found in toJson also in the formdata separately
        'images': await MultipartFile.fromFile(
          successStory.images!.toList().toString(),
          filename: 'reunited_image.jpg',
        ),
      };
      final response = await _dio.post(
        '/success-story',
        data: formData,
      );

      if (response.statusCode == 200) {
        print('Successfuly create success story');
      } else {
        return const Left(ServerFailure('unable to load'));
      }
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
    return const Right(null);
  }

  Future<Either<Failure, SuccessStoryEntity>> getSuccessStoryById(
      String storyId) async {
    try {
      final response = await _dio.post(
        '/success-story/$storyId',
      );

      if (response.statusCode == 200) {
        SuccessStoryModel model = SuccessStoryModel.fromJson(response.data);
        return Right(model.toEntity());
      } else {
        return const Left(ServerFailure('unable to load'));
      }
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }

  Future<List<SuccessStoryEntity>> getSuccessStories({String? userId}) async {
    try {
      final response = await _dio.get(
        '/success-story',
        queryParameters: {'title': 'reunited'},
      );

      if (response.statusCode == 200) {
        print(response.data['data']);
        final List<SuccessStoryModel> stories = (response.data['data'] as List)
            .map((story) => SuccessStoryModel.fromJson(story))
            .toList();
        print("Story MODEL \n $stories");
        final List<SuccessStoryEntity> storyEntity =
            stories.map((json) => json.toEntity()).toList();
        print(Right(storyEntity[0].content));
        // return Right(storyEntity);
        return storyEntity;
      } else {
        throw Exception();
      }
    } catch (e) {
      return throw Exception(e.toString());
    }
  }

  Future<Either<Failure, void>> removeSuccessStory(
      SuccessStoryEntity story) async {
    try {
      final response = await _dio.patch(
        '/success-story/remove/${story.id}',
        queryParameters: {
          'title': {story.title}
        },
      );

      if (response.statusCode == 200) {
        return const Right(null);
      } else {
        return const Left(ServerFailure('unable to load'));
      }
    } catch (e) {
      return left(ConnectionFailure(e.toString()));
    }
  }
}
