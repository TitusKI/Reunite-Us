import 'package:afalagi/core/error/failure.dart';
import 'package:afalagi/domain/entities/comment/edit_comment_entity.dart';
import 'package:afalagi/domain/entities/comment/post_comment_entity.dart';
import 'package:afalagi/domain/entities/comment/story_comment_entity.dart';
import 'package:dartz/dartz.dart';

abstract class CommentRepository {
  Future<Either<Failure, void>> createPostComment(PostCommentEntity comment);
  Future<Either<Failure, void>> createStoryComment(StoryCommentEntity comment);
  Future<Either<Failure, String>> editComment(EditCommentEntity comment);

  Future<Either<Failure, String>> toggleLikeStory(String storyId);
}
