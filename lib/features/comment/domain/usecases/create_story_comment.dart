import 'package:afalagi/core/error/failure.dart';
import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/features/comment/domain/entities/story_comment_entity.dart';
import 'package:afalagi/features/comment/domain/repository/comment_repository.dart';
import 'package:afalagi/injection_container.dart';
import 'package:dartz/dartz.dart';

class CreateStoryCommentUsecase
    implements Usecase<Either<Failure, void>, StoryCommentEntity> {
  @override
  Future<Either<Failure, void>> call({StoryCommentEntity? parms}) async {
    return await sl<CommentRepository>().createStoryComment(parms!);
  }
}
