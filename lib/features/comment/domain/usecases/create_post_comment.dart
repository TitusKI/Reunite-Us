import 'package:afalagi/core/error/failure.dart';
import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/features/comment/domain/entities/post_comment_entity.dart';
import 'package:afalagi/features/comment/domain/repository/comment_repository.dart';
import 'package:afalagi/injection_container.dart';
import 'package:dartz/dartz.dart';

class CreatePostCommentUsecase
    extends Usecase<Either<Failure, void>, PostCommentEntity> {
  @override
  Future<Either<Failure, void>> call({PostCommentEntity? parms}) async {
    return await sl<CommentRepository>().createPostComment(parms!);
  }
}
