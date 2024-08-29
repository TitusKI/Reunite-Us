// data/models/success_story_model.dart

import 'dart:core';

import 'package:afalagi/data/models/user/user_model.dart';
import 'package:afalagi/data/models/Comment/comment_model.dart';
import 'package:afalagi/data/models/success_story/closed_case_model.dart';
import 'package:afalagi/data/models/success_story/likes_model.dart';
import 'package:afalagi/domain/entities/success_story/success_story_entity.dart';

class SuccessStoryModel {
  final String? id;
  final String? userId;
  final String title;
  final String content;
  final String closedCaseId;
  final List<String>? images;
  final List<String>? videoLink;
  final ClosedCaseModel? closedCase;
  final User? user;
  final List<Comment>? comments;
  final List<Likes>? likes;

  SuccessStoryModel({
    this.userId,
    this.videoLink,
    this.closedCase,
    this.user,
    this.comments,
    this.likes,
    this.id,
    required this.title,
    required this.content,
    required this.closedCaseId,
    required this.images,
  });

  // For Creating SuccessStory
  // Convert from Entity to Model
  factory SuccessStoryModel.fromEntity(SuccessStoryEntity entity) {
    return SuccessStoryModel(
      title: entity.title!,
      content: entity.content!,
      closedCaseId: entity.closedCaseId!,
      images: entity.images!,
      videoLink: entity.videoLink!,
      closedCase: entity.closedCase,
      user: entity.user,
      comments: entity.comments,
      likes: entity.likes,
      id: entity.id,
    );
  }
  // For Creating SuccessStory
  // Convert Models to Json to the api
  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'content': content,
      'closedCaseId': closedCaseId,
      "images": images,
    };
  }

// For fetching success story from the api
  // Convert JSON to SuccessStoryModel
  factory SuccessStoryModel.fromJson(Map<String, dynamic> json) {
    return SuccessStoryModel(
      id: json['id'],
      title: json['title'],
      content: json['content'],
      closedCaseId: json['closedCaseId'],
      images: List<String>.from(json['images']),
      // videoLink: List<String>.from(json['videoLink']),
      // closedCase: ClosedCaseModel.fromJson(json['closedCase']),
      user: User.fromJson(json['user']),
      // comments: (json['comments'] as List)
      //     .map((json) => Comment.fromJson(json))
      //     .toList(),
      // likes:
      //     (json['likes'] as List).map((json) => Likes.fromJson(json)).toList(),
    );
  }
// those that shoul display on the presentation layer
  // Convert SuccessStoryModel to entity
  SuccessStoryEntity toEntity() {
    return SuccessStoryEntity(
      title: title,
      content: content,
      closedCaseId: closedCaseId,
      images: images,
      id: id!,
      videoLink: videoLink,
      closedCase: closedCase,
      user: user,
      comments: comments,
      likes: likes,
    );
  }
}
