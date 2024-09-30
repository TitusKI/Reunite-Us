import 'package:afalagi/features/user/data/models/user_model.dart';
import 'package:afalagi/features/comment/domain/entities/edit_comment_entity.dart';
import 'package:afalagi/features/comment/domain/entities/post_comment_entity.dart';
import 'package:afalagi/features/comment/domain/entities/story_comment_entity.dart';

class Comment {
  final String? id;
  final String? postId;
  final String? userId;
  final String? parentId;
  final String? successStoryId;
  final String commentText;
  final int? replies;
  final User? user;

  Comment({
    this.replies,
    this.user,
    this.parentId,
    this.successStoryId,
    this.id,
    this.postId,
    this.userId,
    required this.commentText,
  });
  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      replies: json['_count']['replies'],
      commentText: json['commentText'],
      id: json['id'],
      postId: json['postId'],
      userId: json['userId'],
      parentId: json['parentId'],
      successStoryId: json['successStoryId'],
      user: User.fromJson(json['user']),
    );
  }
  // For Creating SuccessStory
  // Convert from Entity to Model
  factory Comment.fromPostEntity(PostCommentEntity entity) {
    return Comment(
        postId: entity.postId,
        commentText: entity.commentText,
        user: entity.user);
  }
  // For Creating SuccessStory
  // Convert Models to Json to the api
  Map<String, dynamic> toPostJson() {
    return {
      "postId": postId,
      "commentText": commentText,
      "parentId": parentId,
    };
  }

  // For Creating SuccessStory
  // Convert from Entity to Model
  factory Comment.fromStoryEntity(StoryCommentEntity entity) {
    return Comment(
        successStoryId: entity.successStoryId,
        commentText: entity.commentText,
        parentId: entity.parentId,
        user: entity.user);
  }
  // For Creating SuccessStory
  // Convert Models to Json to the api
  Map<String, dynamic> toStoryJson() {
    return {
      "successStoryId": successStoryId,
      "commentText": commentText,
      'parentId': parentId,
    };
  }

  // For Editing Comment
  // Convert from Entity to Model
  factory Comment.fromEditEntity(EditCommentEntity entity) {
    return Comment(id: entity.id, commentText: entity.commentText);
  }
  // For Creating SuccessStory
  // Convert Models to Json to the api
  Map<String, dynamic> toEditJson() {
    return {
      "id": id,
      "commentText": commentText,
    };
  }
  // PostCommentEntity toPostEntity() {
  //   return PostCommentEntity(
  //     postId: postId!,
  //     commentText: commentText,
  //   );
  // }

  // StoryCommentEntity toStoryEntity() {
  //   return StoryCommentEntity(
  //     successStoryId: successStoryId!,
  //     commentText: commentText,
  //   );
  // }
}
