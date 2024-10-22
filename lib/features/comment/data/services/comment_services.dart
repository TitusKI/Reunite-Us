import 'package:afalagi/core/constants/constant.dart';
import 'package:afalagi/injection_container.dart';
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';
import 'package:afalagi/core/constants/data_export.dart';
import 'package:afalagi/core/constants/domain_export.dart';
import 'package:afalagi/core/error/failure.dart';

class CommentServices {
  final storageService = sl<StorageService>();

  final baseUrl = AppConstant.BASE_URL;
  final Dio _dio = Dio(BaseOptions(
    // Ewenet
    // baseUrl: "http://192.168.100.186:3333/api",
// home
    // baseUrl: "http://192.168.43.184:3333/api",
    baseUrl: AppConstant.BASE_URL,
    headers: {'Content-Type': 'application/json'},
  ));
//  CommentServices(this.storageService);

  CommentServices() {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          print("Request starting ...");
          // List of paths that need headers
          const pathsWithHeaders = [
            '/comment/post',
            '/comment/story',
            '/comment/',

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

  Future<Either<Failure, void>> createPostComment(
      PostCommentEntity comment) async {
    final postComments = Comment.fromPostEntity(comment).toPostJson();
    try {
      final response = await _dio.patch('/comment/post', data: postComments);

      if (response.statusCode == 200) {
        return const Right('Comment send successfully');
      } else {
        return const Left(ServerFailure('unable to load'));
      }
    } catch (e) {
      return left(ConnectionFailure(e.toString()));
    }
  }

  Future<Either<Failure, void>> createStoryComment(
      StoryCommentEntity comment) async {
    final storyComment = Comment.fromStoryEntity(comment).toStoryJson();
    try {
      final response = await _dio.patch('/comment/story', data: storyComment);

      if (response.statusCode == 200) {
        return const Right('Comment send successfully');
      } else {
        return const Left(ServerFailure('unable to load'));
      }
    } catch (e) {
      return left(ConnectionFailure(e.toString()));
    }
  }

  Future<Either<Failure, String>> editComment(EditCommentEntity comment) async {
    final accessToken = storageService.getAccessToken();
    final editedComment = Comment.fromEditEntity(comment).toEditJson();
    final Dio dio = Dio();
    try {
      final response = await dio.patch("$baseUrl/comment/${comment.id}",
          data: editedComment,
          options: Options(headers: {'Authorization': "Bearer $accessToken"}));
      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(ServerFailure(response.statusMessage ?? 'Unknown Error'));
      }
    } catch (e) {
      return Left(ServerFailure(e.toString()));
    }
  }

  Future<Either<Failure, String>> toggleLikeStory(String storyId) async {
    final Dio dio = Dio();
    final accessToken = storageService.getAccessToken();
    try {
      final response = await dio.post("$baseUrl/like/$storyId",
          options: Options(headers: {'Authorization': "Bearer $accessToken"}));
      if (response.statusCode == 200) {
        return Right(response.data);
      } else {
        return Left(response.data);
      }
    } catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
