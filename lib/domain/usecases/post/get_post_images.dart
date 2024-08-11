import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/domain/entities/post/post_images_entity.dart';
import 'package:afalagi/domain/repository/post/post_repository.dart';
import 'package:afalagi/injection_container.dart';

class GetPostImagesUsecase extends Usecase<PostImagesEntity, String> {
  @override
  Future<PostImagesEntity> call({String? parms}) {
    return sl<PostRepository>().getPostImages(parms!);
  }
}
