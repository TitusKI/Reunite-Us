import 'package:afalagi/data/models/user/user_model.dart';

class StoryCommentEntity {
  final String? id;
  final String successStoryId;
  final String? userId;
  final String commentText;
  final String? parentId;
  final User? user;

  StoryCommentEntity({
    this.user,
    this.id,
    required this.successStoryId,
    this.userId,
    required this.commentText,
    this.parentId,
  });
}
