import 'package:afalagi/core/constants/domain_export.dart';
import 'package:afalagi/core/constants/presentation_export.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../core/constants/data_export.dart';
import '../../../../../comment/presentation/bloc/comment_cubit.dart';

class CommentSection extends StatefulWidget {
  final MissingPersonEntity post;

  const CommentSection({super.key, required this.post});

  @override
  _CommentSectionState createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  final TextEditingController commentController = TextEditingController();

  // Map to track visibility of replies for each comment
  final Map<String, bool> _showReplies = {};

  @override
  Widget build(BuildContext context) {
    final List<Comment>? allComments = widget.post.comment;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
        left: 16.w,
        right: 16.w,
        top: 16.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Comments',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10.h),
          Expanded(
            child: (allComments == null || allComments.isEmpty)
                ? const Center(child: Text('No comments yet'))
                : ListView.builder(
                    itemCount:
                        allComments.where((c) => c.parentId == null).length,
                    itemBuilder: (context, index) {
                      final comment = allComments
                          .where((c) => c.parentId == null)
                          .elementAt(index);
                      return _buildCommentItem(context, comment, allComments);
                    },
                  ),
          ),
          SizedBox(height: 16.h),
          _buildCommentInputField(context, commentController),
        ],
      ),
    );
  }

  // Build the comment item with potential replies
  Widget _buildCommentItem(
      BuildContext context, Comment comment, List<Comment> allComments) {
    print("The id of this comment is ${comment.id}");
    bool showReplies = _showReplies[comment.id] ??
        false; // Get visibility state, default to false
    final replies = allComments.where((c) => c.parentId == comment.id).toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Card(
        elevation: 2,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Display the user name of the comment
              Text(
                comment.user!.profile.firstName ?? 'Anonymous',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 4.h),

              // Display the actual comment text
              Text(
                comment.commentText,
                style: TextStyle(fontSize: 14.sp),
              ),
              const SizedBox(height: 4.0),

              // 'Reply' button and display replies count if there are any replies
              TextButton(
                onPressed: () {
                  _showReplyInputField(context, comment);
                },
                child: const Text(
                  'Reply',
                  style: TextStyle(color: Colors.blue),
                ),
              ),

              if (replies.isNotEmpty)
                TextButton(
                  onPressed: () {
                    setState(() {
                      _showReplies[comment.id!] = !_showReplies[comment.id]! ??
                          true; // Toggle reply visibility, default to true if null
                    });
                  },
                  child: Text(
                    '${replies.length} replies',
                    style: const TextStyle(color: Colors.blue),
                  ),
                ),

              // Display the replies if available and the toggle is active
              if (!showReplies)
                Padding(
                  padding: const EdgeInsets.only(left: 16.0),
                  child: Column(
                    children: _buildReplies(context, comment, allComments),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }

  // Build the replies of a comment
  List<Widget> _buildReplies(
      BuildContext context, Comment comment, List<Comment> allComments) {
    // Filter the list of comments to find replies to the given comment
    final replies = allComments.where((c) => c.parentId == comment.id).toList();

    // Recursively build each reply comment
    return replies
        .map((reply) => _buildCommentItem(context, reply, allComments))
        .toList();
  }

  // Method to show the reply input field
  void _showReplyInputField(BuildContext context, Comment parentComment) {
    final TextEditingController replyController = TextEditingController();

    // Show a modal bottom sheet for replying
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).viewInsets.bottom,
            left: 16.w,
            right: 16.w,
            top: 16.h,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Reply to ${parentComment.user!.profile.firstName}',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20.sp,
                  color: Colors.black,
                ),
              ),
              SizedBox(height: 10.h),
              TextField(
                controller: replyController,
                decoration: InputDecoration(
                  hintText: 'Write a reply...',
                  filled: true,
                  fillColor: Colors.grey.shade200,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                  suffixIcon: IconButton(
                    icon: const Icon(Icons.send),
                    onPressed: () {
                      if (replyController.text.isNotEmpty) {
                        // Create a new reply (PostCommentEntity) linked to the parent comment
                        final reply = PostCommentEntity(
                          postId: parentComment.postId!,
                          commentText: replyController.text,
                          parentId: parentComment.id, // Link to parent comment
                        );

                        // Dispatch the createReply action to the CommentCubit
                        context.read<CommentCubit>().createPostComment(reply);

                        // Clear the text field after sending the reply
                        replyController.clear();
                      }
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildCommentInputField(
      BuildContext context, TextEditingController controller) {
    return TextField(
      controller: controller,
      decoration: InputDecoration(
        hintText: 'Write a comment...',
        filled: true,
        fillColor: Colors.grey.shade200,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide.none,
        ),
        suffixIcon: IconButton(
          icon: const Icon(Icons.send),
          onPressed: () {
            if (controller.text.isNotEmpty) {
              context.read<CommentCubit>().createPostComment(
                    PostCommentEntity(
                      postId: widget.post.id!,
                      commentText: controller.text,
                    ),
                  );
              controller.clear();
            }
          },
        ),
      ),
    );
  }
}
