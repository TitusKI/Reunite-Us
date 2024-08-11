import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/domain/entities/post/missing_person_entity.dart';
import 'package:afalagi/domain/repository/post/post_repository.dart';
import 'package:afalagi/injection_container.dart';

class GetMyPostsUsecase implements Usecase<List<MissingPersonEntity>, void> {
  @override
  Future<List<MissingPersonEntity>> call({void parms}) {
    return sl<PostRepository>().getMyPosts();
  }
}
