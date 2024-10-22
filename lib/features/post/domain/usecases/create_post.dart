import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/features/post/domain/entities/missing_person_entity.dart';
import 'package:afalagi/features/post/domain/repository/post_repository.dart';
import 'package:afalagi/injection_container.dart';

class CreatePostUsecase implements Usecase<void, MissingPersonEntity> {
  @override
  Future<void> call({MissingPersonEntity? parms}) {
    return sl<PostRepository>().createPost(parms!);
  }
}
