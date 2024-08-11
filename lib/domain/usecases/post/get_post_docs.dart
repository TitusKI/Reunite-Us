import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/domain/entities/post/post_docs_entity.dart';
import 'package:afalagi/domain/repository/post/post_repository.dart';
import 'package:afalagi/injection_container.dart';

class GetPostDocsUsecase extends Usecase<PostDocsEntity, String> {
  @override
  Future<PostDocsEntity> call({String? parms}) {
    return sl<PostRepository>().getPostDocs(parms!);
  }
}
