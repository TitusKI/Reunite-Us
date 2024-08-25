import 'package:afalagi/core/error/failure.dart';
import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/domain/entities/comment/edit_comment_entity.dart';
import 'package:afalagi/domain/repository/comment/comment_repository.dart';
import 'package:afalagi/injection_container.dart';
import 'package:dartz/dartz.dart';

class EditCommentUsecase
    extends Usecase<Either<Failure, String>, EditCommentEntity> {
  @override
  Future<Either<Failure, String>> call({EditCommentEntity? parms}) async {
    return await sl<CommentRepository>().editComment(parms!);
  }
}
