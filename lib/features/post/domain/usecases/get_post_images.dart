import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/features/post/domain/entities/post_images_entity.dart';
import 'package:afalagi/features/post/domain/repository/post_repository.dart';
import 'package:afalagi/injection_container.dart';

class GetPostImagesUsecase extends Usecase<PostImagesEntity, String> {
  @override
  Future<PostImagesEntity> call({String? parms}) {
    return sl<PostRepository>().getPostImages(parms!);
  }
}
