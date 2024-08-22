// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:afalagi/core/constants/data_export.dart';
import 'package:afalagi/data/models/user/user_model.dart';
import 'package:afalagi/data/models/success_story/closed_case_model.dart';
import 'package:afalagi/data/models/success_story/likes_model.dart';

class SuccessStoryEntity {
  final String id;
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
    required this.id,
    this.title,
    this.content,
    this.closedCaseId,
    this.images,
  });
}
