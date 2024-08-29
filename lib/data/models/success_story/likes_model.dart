// ignore_for_file: public_member_api_docs, sort_constructors_first

import 'dart:convert';

import 'package:afalagi/data/models/user/user_model.dart';

class Likes {
  final String? id;
  final String? userId;
  final String? successStoryId;
  final User? user;
  Likes({
    this.id,
    this.userId,
    this.successStoryId,
    this.user,
  });

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'userId': userId,
      'successStoryId': successStoryId,
      'user': user?.toEntity(),
    };
  }

  factory Likes.fromMap(Map<String, dynamic> map) {
    return Likes(
      id: map['id'] != null ? map['id'] as String : null,
      userId: map['userId'] != null ? map['userId'] as String : null,
      successStoryId: map['successStoryId'] != null
          ? map['successStoryId'] as String
          : null,
      user: map['user'] != null
          ? User.fromJson(map['user'] as Map<String, dynamic>)
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Likes.fromJson(String source) =>
      Likes.fromMap(json.decode(source) as Map<String, dynamic>);
}
