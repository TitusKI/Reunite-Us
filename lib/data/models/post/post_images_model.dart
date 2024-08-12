// data/models/post_images_model.dart

import 'package:afalagi/domain/entities/post/post_images_entity.dart';

class PostImagesModel extends PostImagesEntity {
  // ignore: use_super_parameters
  PostImagesModel({
    required List<String> images,
  }) : super(images: images);

  factory PostImagesModel.fromJson(Map<String, dynamic> json) {
    return PostImagesModel(
      images: List<String>.from(json['images']),
    );
  }
}
