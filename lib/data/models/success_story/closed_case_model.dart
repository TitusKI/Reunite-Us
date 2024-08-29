import 'dart:convert';

import 'package:afalagi/domain/entities/post/closed_case_entity.dart';

// ignore_for_file: public_member_api_docs, sort_constructors_first
class ClosedCaseModel {
  final Future<String?>? id;
  final String? foundCondition;
  final String? foundDate;
  final String? foundLocation;
  final String? foundThrough;
  final String? description;
  ClosedCaseModel({
    this.id,
    this.foundCondition,
    this.foundDate,
    this.foundLocation,
    this.foundThrough,
    this.description,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'foundCondition': foundCondition,
      'foundDate': foundDate,
      'foundLocation': foundLocation,
      'foundThrough': foundThrough,
      'description': description,
    };
  }

  factory ClosedCaseModel.fromMap(Map<String, dynamic> map) {
    return ClosedCaseModel(
      id: map['id'] != null ? map['id'] as Future<String> : null,
      foundCondition: map['foundCondition'] != null
          ? map['foundCondition'] as String
          : null,
      foundDate: map['foundDate'] != null ? map['foundDate'] as String : null,
      foundLocation:
          map['foundLocation'] != null ? map['foundLocation'] as String : null,
      foundThrough:
          map['foundThrough'] != null ? map['foundThrough'] as String : null,
      description:
          map['description'] != null ? map['description'] as String : null,
    );
  }

  factory ClosedCaseModel.fromEntity(ClosedCaseEntity entity) {
    return ClosedCaseModel(
      id: entity.id,
      foundCondition: entity.foundCondition,
      foundDate: entity.foundDate,
      foundLocation: entity.foundLocation,
      foundThrough: entity.foundThrough,
      description: entity.description,
    );
  }
  String toJson() => json.encode(toMap());

  factory ClosedCaseModel.fromJson(String source) =>
      ClosedCaseModel.fromMap(json.decode(source) as Map<String, dynamic>);
}
