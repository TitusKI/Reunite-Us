import 'package:afalagi/core/error/failure.dart';
import 'package:afalagi/data/services/remote/comment_services.dart';
import 'package:afalagi/domain/entities/comment/edit_comment_entity.dart';
import 'package:afalagi/domain/entities/comment/post_comment_entity.dart';
import 'package:afalagi/domain/entities/comment/story_comment_entity.dart';
import 'package:afalagi/domain/repository/comment/comment_repository.dart';
import 'package:afalagi/injection_container.dart';
import 'package:dartz/dartz.dart';

class CommentRepositoryImpl implements CommentRepository {
  @override
  Future<Either<Failure, void>> createPostComment(
      PostCommentEntity comment) async {
    return await sl<CommentServices>().createPostComment(comment);
  }

  @override
  Future<Either<Failure, void>> createStoryComment(
      StoryCommentEntity comment) async {
    return await sl<CommentServices>().createStoryComment(comment);
  }

  @override
  Future<Either<Failure, String>> toggleLikeStory(String storyId) async {
    return await sl<CommentServices>().toggleLikeStory(storyId);
  }

  @override
  Future<Either<Failure, String>> editComment(EditCommentEntity comment) async {
    return await sl<CommentServices>().editComment(comment);
  }
}
