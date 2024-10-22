import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/features/post/domain/entities/update_post_entity.dart';
import 'package:afalagi/features/post/domain/repository/post_repository.dart';
import 'package:afalagi/injection_container.dart';

class EditPostByIdUsecase extends Usecase<void, UpdatePostEntity> {
  @override
  Future<void> call({UpdatePostEntity? parms}) {
    return sl<PostRepository>().editPostById(parms!);
  }
}
