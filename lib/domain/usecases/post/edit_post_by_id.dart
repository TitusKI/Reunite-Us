import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/domain/entities/post/update_post_entity.dart';
import 'package:afalagi/domain/repository/post/post_repository.dart';
import 'package:afalagi/injection_container.dart';

class EditPostByIdUsecase extends Usecase<void, UpdatePostEntity> {
  @override
  Future<void> call({UpdatePostEntity? parms}) {
    return sl<PostRepository>().editPostById(parms!);
  }
}
