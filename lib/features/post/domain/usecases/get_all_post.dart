import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/features/post/domain/entities/missing_person_entity.dart';
import 'package:afalagi/features/post/domain/repository/post_repository.dart';
import 'package:afalagi/injection_container.dart';

class GetAllPostUsecase implements Usecase<List<MissingPersonEntity>, void> {
  @override
  Future<List<MissingPersonEntity>> call({void parms}) {
    return sl<PostRepository>().getAllPosts();
  }
}
