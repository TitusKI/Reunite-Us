import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/domain/entities/post/missing_person_entity.dart';
import 'package:afalagi/domain/repository/post/post_repository.dart';
import 'package:afalagi/injection_container.dart';

class CreatePostUsecase implements Usecase<void, MissingPersonEntity> {
  @override
  Future<void> call({MissingPersonEntity? parms}) {
    return sl<PostRepository>().createPost(parms!);
  }
}
