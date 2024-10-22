import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/features/post/domain/entities/closed_case_entity.dart';
import 'package:afalagi/features/post/domain/repository/post_repository.dart';
import 'package:afalagi/injection_container.dart';

class ClosePostUsecase extends Usecase<void, ClosedCaseEntity> {
  @override
  Future<void> call({ClosedCaseEntity? parms}) {
    return sl<PostRepository>().closePost(parms!);
  }
}
