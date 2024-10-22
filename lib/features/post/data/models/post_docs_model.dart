// data/models/post_docs_model.dart

import 'package:afalagi/features/post/domain/entities/post_docs_entity.dart';

class PostDocsModel extends PostDocsEntity {
  PostDocsModel({
    required super.docs,
  });

  factory PostDocsModel.fromJson(Map<String, dynamic> json) {
    return PostDocsModel(
      docs: List<String>.from(json['legalDocuments']),
    );
  }
}
