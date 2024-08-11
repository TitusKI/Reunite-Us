import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/domain/entities/post/missing_person_entity.dart';
import 'package:afalagi/domain/repository/post/post_repository.dart';
import 'package:afalagi/injection_container.dart';

class GetPostByIdUsecase extends Usecase<MissingPersonEntity, String> {
  @override
  Future<MissingPersonEntity> call({String? parms}) {
    return sl<PostRepository>().getPostById(parms!);
  }
}
