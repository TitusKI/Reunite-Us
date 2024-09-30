// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:afalagi/core/constants/data_export.dart';
import 'package:afalagi/features/user/data/models/user_model.dart';
import 'package:afalagi/features/success_stories/data/models/closed_case_model.dart';
import 'package:afalagi/features/success_stories/data/models/likes_model.dart';

class SuccessStoryEntity {
  final String? id;
  String? title;
  String? content;
  String? closedCaseId;
  List<String>? images;
  final List<String>? videoLink;
  final ClosedCaseModel? closedCase;
  final User? user;
  final List<Comment>? comments;
  final List<Likes>? likes;
  SuccessStoryEntity({
    this.videoLink,
    this.closedCase,
    this.user,
    this.comments,
    this.likes,
    this.id,
    this.title,
    this.content,
    this.closedCaseId,
    this.images,
  });
}
