import 'package:afalagi/core/constants/constant.dart';
import 'package:afalagi/core/constants/domain_export.dart';
import 'package:afalagi/core/constants/presentation_export.dart';
import 'package:afalagi/features/comment/data/models/comment_model.dart';
import 'package:afalagi/features/success_stories/domain/entities/success_story_entity.dart';
import 'package:afalagi/features/comment/presentation/bloc/comment_cubit.dart';
import 'package:afalagi/config/theme/colors.dart';
import 'package:afalagi/features/success_stories/presentation/bloc/success_story_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  void initState() {
    super.initState();
    // Fetch all user posts when the screen is loaded
    context.read<PostsCubit>().fetchAllPosts();
    context.read<SuccessStoryCubit>().getSuccessStories();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:

            // print(posts[1].comment![0].commentText);
            SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0.w),
            child: TextField(
              decoration: InputDecoration(
                hintText: 'Start typing a name',
                hintStyle:
                    const TextStyle(color: AppColors.primarySecondaryText),
                prefixIcon: const Icon(
                  Icons.search,
                  color: AppColors.secondaryColor,
                ),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20.r),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Found Persons',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    color: AppColors.secondaryColor,
                  ),
                ),
                IconButton(
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: AppColors.accentColor,
                  ),
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.FOUND);
                    // handle navigation to all found persons
                  },
                ),
              ],
            ),
          ),
          BlocBuilder<SuccessStoryCubit, GenericState>(
            builder: (context, state) {
              if (state.isLoading) {
                return SizedBox(
                  height: 185.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount:
                        3, // replace with the actual number of found persons
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: EdgeInsets.all(8.0.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 100.w,
                              height: 100.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                color: AppColors.loadingColor,
                              ),
                            ),
                            SizedBox(height: 8.h),
                            Container(
                              width: 90.w,
                              height: 20.h,
                              decoration: const BoxDecoration(
                                color: AppColors.loadingColor,
                              ),
                            ), // replace with actual name
                          ],
                        ),
                      );
                    },
                  ),
                );
              }

              // if (state.failure != null || state.failure!.isNotEmpty) {
              //   return Center(
              //     child: Text(
              //       "Error: ${state.failure}",
              //       style: const TextStyle(color: AppColors.secondaryColor),
              //     ),
              //   );
              // }

              if (state.isSuccess) {
                final List<SuccessStoryEntity> stories = state.data ?? [];
                // print(posts[1].comment![0].commentText);

                return SizedBox(
                  height: 185.h,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: stories
                        .length, // replace with the actual number of found persons
                    itemBuilder: (context, index) {
                      final story = stories[index];
                      final profile = story.user!.profile;

                      return Padding(
                        padding: EdgeInsets.all(8.0.w),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              width: 100.w,
                              height: 100.h,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10.r),
                                image: const DecorationImage(
                                  image: AssetImage(
                                      'assets/temp/foundChild.jpg'), // replace with actual image path
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            SizedBox(height: 8.h),
                            SizedBox(
                              width: 90.w,
                              child: Text(
                                "${profile.firstName} ${profile.middleName} ${profile.lastName}",
                                style: TextStyle(
                                    fontSize: 14.sp,
                                    color: AppColors.secondaryColor),
                              ),
                            ), // replace with actual name
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
              return Container(
                height: 0,
              );
            },
          ),
          Divider(
            color: AppColors.secondaryColor,
            endIndent: 8.0.w,
          ),
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w),
            child: Align(
              alignment: Alignment.centerLeft,
              child: Text(
                'Missing Persons',
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    color: AppColors.secondaryColor),
              ),
            ),
          ),

          // List of fetched posts
          BlocBuilder<PostsCubit, GenericState>(
            builder: (context, state) {
              print("Missing Persons Data");
              print(state.data);

              if (state.isLoading) {
                return Center(
                  child: Container(),
                );
              }

              // if (state.failure != null || state.failure!.isNotEmpty) {
              //   return Center(
              //     child: Text(
              //       "Error: ${state.failure}",
              //       style: const TextStyle(color: AppColors.secondaryColor),
              //     ),
              //   );
              // }

              if (state.isSuccess) {
                final List<MissingPersonEntity> posts = state.data ?? [];
                return Padding(
                  padding: EdgeInsets.all(16.0.w),
                  child: GridView.builder(
                    physics: const NeverScrollableScrollPhysics(),
                    shrinkWrap: true,
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 1,
                      childAspectRatio: 0.6.dg,
                      crossAxisSpacing: 10.w,
                      mainAxisSpacing: 10.h,
                    ),
                    itemCount: posts.length,
                    itemBuilder: (context, index) {
                      print("Number of posts is : ");
                      print(posts.length);
                      final MissingPersonEntity post = posts[index];
                      final profilePictureUrl =
                          '${AppConstant.UPLOAD_BASE_URL}/profile/${post.user!.profile.profilePicture}';
                      final postPictureUrl =
                          '${AppConstant.UPLOAD_BASE_URL}/post/${post.postImages[0]}';
                      return Card(
                        clipBehavior: Clip.hardEdge,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(15.r),
                            topRight: Radius.circular(15.r),
                          ),
                        ),
                        elevation: 5.h,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            ListTile(
                              leading: GestureDetector(
                                onTap: () {
                                  Navigator.of(context).pushNamed(
                                      AppRoutes.PROFILE_DETAIL,
                                      arguments: post);
                                },
                                child: CircleAvatar(
                                  backgroundImage: NetworkImage(
                                      profilePictureUrl), // Replace with actual image URL
                                ),
                              ),
                              title: Text(
                                "${post.user!.profile.firstName} ${post.user!.profile.middleName} ${post.user!.profile.lastName}", // Replace with actual user name
                                style: TextStyle(fontSize: 12.sp),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              height: 200.h,
                              decoration: BoxDecoration(
                                // borderRadius: BorderRadius.only(
                                //   topLeft: Radius.circular(15.r),
                                //   topRight: Radius.circular(15.r),
                                // ),
                                image: DecorationImage(
                                  image: NetworkImage(
                                      postPictureUrl), // Replace with actual image URL
                                  fit: BoxFit.fill,
                                ),
                              ),
                            ),
                            Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: Text(
                                "${post.firstName} ${post.middleName} ${post.lastName}", // Replace with actual post title
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: AppColors.secondaryColor,
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "Last Seen Location: ${post.lastSeenLocation}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.secondaryColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                "Date of Disapperance: ${post.lastSeenDate}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: AppColors.secondaryColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 8.0),
                              child: Text(
                                post.description,
                                overflow: TextOverflow.fade,
                                // Replace with actual post description
                                style: const TextStyle(
                                    color: AppColors.secondaryColor),
                                textAlign: TextAlign.center,
                              ),
                            ),
                            const Spacer(),
                            Padding(
                              padding: EdgeInsets.all(8.0.w),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                      Icons.comment_sharp,
                                      color: AppColors.accentColor,
                                    ),
                                    onPressed: () {
                                      // print(post.comment![0].commentText);
                                      _showCommentSection(context, post);
                                    },
                                  ),
                                  TextButton(
                                    style: const ButtonStyle(
                                      backgroundColor: WidgetStatePropertyAll(
                                          AppColors.accentColor),
                                      foregroundColor: WidgetStatePropertyAll(
                                          AppColors.primaryBackground),
                                    ),
                                    child: const Text('View Details'),
                                    onPressed: () {
                                      Navigator.of(context).pushNamed(
                                          AppRoutes.MISSING_DETAIL,
                                          arguments: post);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
              return Container();
            },
          ),
          TextButton(
            style: const ButtonStyle(
                foregroundColor: WidgetStatePropertyAll(AppColors.accentColor)),
            child: const Text('See More'),
            onPressed: () {
              // handle see more action
            },
          ),
        ],
      ),
    ));
  }

  // Show comment section as a modal or inline
  void _showCommentSection(BuildContext context, MissingPersonEntity post) {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        // print(post.comment![0].commentText);

        return CommentSection(
          post,
        ); // Pass the postId to the comment section
      },
    );
  }

  Widget CommentSection(MissingPersonEntity? missingPerson) {
    print(missingPerson!.comment![0].commentText);

    final comments = missingPerson.comment;
    print(missingPerson.count);
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
            child: comments!.isEmpty
                ? const Center(
                    child: Text('No comments yet'), // No comments message
                  )
                : ListView.builder(
                    itemCount: comments.length,
                    itemBuilder: (context, index) {
                      final comment = comments[index];

                      return _buildCommentItem(comment);
                    },
                  ),
          ),

          SizedBox(height: 16.h),

          // TextField for the user to write a new comment
          _buildCommentInputField(context, commentController, missingPerson),
        ],
      ),
    );
  }

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
  Widget _buildCommentInputField(BuildContext context,
      TextEditingController controller, MissingPersonEntity? missingPerson) {
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
                postId: missingPerson!.id!, // Assuming `id` is the post ID
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
