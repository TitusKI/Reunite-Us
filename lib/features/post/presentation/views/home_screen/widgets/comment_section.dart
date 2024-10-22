import 'package:afalagi/core/constants/presentation_export.dart';
import 'package:afalagi/features/comment/data/models/comment_model.dart';
import 'package:afalagi/features/comment/domain/entities/post_comment_entity.dart';
import 'package:afalagi/features/post/domain/entities/missing_person_entity.dart';
import 'package:afalagi/features/comment/presentation/bloc/comment_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

/// The CommentSection widget displays the comments from a MissingPerson entity
/// and allows the user to write a new comment, which will be sent as a single request.
class CommentSection extends StatefulWidget {
  final MissingPersonEntity? missingPerson;

  const CommentSection({
    super.key,
    this.missingPerson, // To associate new comments with the post
  });

  @override
  State<CommentSection> createState() => _CommentSectionState();
}

class _CommentSectionState extends State<CommentSection> {
  late MissingPersonEntity? missingPerson;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    // Extract the passed argument
    final args =
        ModalRoute.of(context)?.settings.arguments as MissingPersonEntity?;
    setState(() {
      missingPerson = args;
    });
  }

  @override
  void initState() {
    super.initState();
    missingPerson = null;
    context.read<CommentCubit>();
  }

  @override
  void dispose() {
    super.dispose();
    CommentCubit().close();
  }

  @override
  Widget build(BuildContext context) {
    final comments = missingPerson?.comment;
    print(comments);
    // Get comments from the entity
    final TextEditingController commentController = TextEditingController();

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom, // Adjust for keyboard
        left: 16.w,
        right: 16.w,
        top: 16.h,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Header for the comments section
          Text(
            'Comments',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20.sp,
              color: Colors.black,
            ),
          ),
          SizedBox(height: 10.h),

          // List of Comments fetched from the MissingPerson entity
          Expanded(
            child: comments != null
                ? ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments[index];

                      return _buildCommentItem(comment);
                    },
                  )
                : const Center(
                    child: Text('No comments yet'), // No comments message
                  ),
          ),
          SizedBox(height: 16.h),

          // TextField for the user to write a new comment
          _buildCommentInputField(context, commentController),
        ],
      ),
    );
  }

  // Method to build each comment item
  Widget _buildCommentItem(Comment comment) {
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
              Text(
                comment.user!.profile.firstName ?? 'Anonymous',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16.sp,
                  color: Colors.blueAccent,
                ),
              ),
              SizedBox(height: 4.h),
              Text(
                comment.commentText,
                style: TextStyle(fontSize: 14.sp),
              ),
              const SizedBox(height: 4.0),
              TextButton(
                onPressed: () {
                  // Handle reply action
                },
                child: const Text(
                  'Reply',
                  style: TextStyle(color: Colors.blue),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Method to build the comment input field
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
              // Create a new PostCommentEntity
              final comment = PostCommentEntity(
                postId:
                    widget.missingPerson!.id!, // Assuming `id` is the post ID
                commentText: controller.text,
              );

              // Dispatch the createPostComment action to the CommentCubit
              context.read<CommentCubit>().createPostComment(comment);

              // Clear the text field after sending the comment
              controller.clear();
            }
          },
        ),
      ),
    );
  }
}
