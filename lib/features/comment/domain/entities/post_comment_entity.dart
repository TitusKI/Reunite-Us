import 'package:afalagi/features/user/data/models/user_model.dart';

class PostCommentEntity {
  final String? id;
  final String postId;
  final String? userId;
  final String commentText;
  final User? user;
  final String? parentId;

  PostCommentEntity({
    this.user,
    this.id,
    required this.postId,
    this.userId,
    this.parentId,
    required this.commentText,
  });
}
