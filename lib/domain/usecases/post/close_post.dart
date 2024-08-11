import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/domain/entities/post/closed_case_entity.dart';
import 'package:afalagi/domain/repository/post/post_repository.dart';
import 'package:afalagi/injection_container.dart';

class ClosePostUsecase extends Usecase<void, ClosedCaseEntity> {
  @override
  Future<void> call({ClosedCaseEntity? parms}) {
    return sl<PostRepository>().closePost(parms!);
  }
}
