import 'package:afalagi/core/error/failure.dart';
import 'package:afalagi/features/comment/data/services/comment_services.dart';
import 'package:afalagi/features/comment/domain/entities/edit_comment_entity.dart';
import 'package:afalagi/features/comment/domain/entities/post_comment_entity.dart';
import 'package:afalagi/features/comment/domain/entities/story_comment_entity.dart';
import 'package:afalagi/features/comment/domain/repository/comment_repository.dart';
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
