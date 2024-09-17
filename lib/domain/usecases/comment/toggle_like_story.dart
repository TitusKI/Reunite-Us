import 'package:afalagi/core/error/failure.dart';
import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/domain/repository/comment/comment_repository.dart';
import 'package:afalagi/injection_container.dart';
import 'package:dartz/dartz.dart';

class ToggleLikeStoryUsecase
    implements Usecase<Either<Failure, String>, String> {
  @override
  Future<Either<Failure, String>> call({String? parms}) async {
    return await sl<CommentRepository>().toggleLikeStory(parms!);
  }
}
