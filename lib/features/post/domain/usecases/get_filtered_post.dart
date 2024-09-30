import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/features/post/domain/entities/missing_person_entity.dart';
import 'package:afalagi/features/post/domain/entities/search_filter.dart';
import 'package:afalagi/features/post/domain/repository/post_repository.dart';
import 'package:afalagi/injection_container.dart';

class GetFilteredPostUsecase
    implements Usecase<List<MissingPersonEntity>, SearchFilterEntity> {
  @override
  Future<List<MissingPersonEntity>> call({SearchFilterEntity? parms}) {
    return sl<PostRepository>().getFilteredPosts(filter: parms);
  }
}
