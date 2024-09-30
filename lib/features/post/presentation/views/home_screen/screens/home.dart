import 'package:afalagi/core/constants/constant.dart';
import 'package:afalagi/core/constants/domain_export.dart';
import 'package:afalagi/core/constants/presentation_export.dart';
import 'package:afalagi/core/util/data_util.dart';
import 'package:afalagi/features/comment/data/models/comment_model.dart';
import 'package:afalagi/features/post/presentation/views/home_screen/widgets/scrollabe_image_container.dart';
import 'package:afalagi/features/success_stories/domain/entities/success_story_entity.dart';
import 'package:afalagi/config/theme/colors.dart';
import 'package:afalagi/features/success_stories/presentation/bloc/success_story_cubit.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../bloc/search_cubit.dart';
import '../widgets/comment_section.dart';

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
        body: SingleChildScrollView(
      child: Column(
        children: [
          Padding(
            padding: EdgeInsets.all(16.0.w),
            child: TextField(
              onChanged: (value) => context.read<SearchCubit>().search(value),
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
          BlocBuilder<SearchCubit, GenericState>(builder: (context, state) {
            // if (state.isLoading) {
            //   return const Center(
            //     child: CircularProgressIndicator(),
            //   );
            // }
            if (state.isSuccess) {
              if (state.data != null &&
                  state.data is List<MissingPersonEntity> &&
                  state.data!.isNotEmpty) {
                return _buildSearchResults(state.data!);
              }
            }
            return const SizedBox.shrink();
          }),
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
              //   return const Center(
              //     child: Text(
              //       "No Internet Connection",
              //       style: TextStyle(color: AppColors.secondaryColor),
              //     ),
              //   );
              // }

              final List<SuccessStoryEntity> stories = state.data ?? [];
              // print(posts[1].comment![0].commentText);
// print(object)

              return SizedBox(
                height: 185.h,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: stories.length > 10
                      ? 10
                      : stories
                          .length, // replace with the actual number of found persons
                  itemBuilder: (context, index) {
                    final story = stories[index];
                    final profile = story.user!.profile;
                    final storyPictureUrl =
                        '${AppConstant.UPLOAD_BASE_URL}/successStory/${story.images![0]}';
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
                              image: DecorationImage(
                                image: NetworkImage(
                                  storyPictureUrl,
                                ), // replace with actual image path
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

              // return Container(
              //   height: 0,
              // );
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
                  child: RawScrollbar(
                    thumbColor: AppColors.cardColor,
                    thickness: 10,
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
                        final List<Comment>? allComments = post.comment;
                        final profilePictureUrl =
                            '${AppConstant.UPLOAD_BASE_URL}/profile/${post.user!.profile.profilePicture}';

                        final List<String> postPictures = post.postImages;
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
                              ScrollableImageContainer(images: postPictures),
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
                                  "Date of Disapperance: ${formatDate(post.lastSeenDate)}",
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
                                    Stack(
                                      children: [
                                        IconButton(
                                          icon: const Icon(
                                            Icons.comment_sharp,
                                            color: AppColors.accentColor,
                                          ),
                                          onPressed: () {
                                            _showCommentSection(context, post);
                                          },
                                        ),
                                        // Show comment count as a subscript if there are comments
                                        if (post.comment != null &&
                                            post.comment!.isNotEmpty)
                                          Positioned(
                                            right: 0,
                                            top: 0,
                                            child: Container(
                                              padding: EdgeInsets.all(3.w),
                                              decoration: const BoxDecoration(
                                                color: Colors
                                                    .red, // Background color for the subscript
                                                shape: BoxShape.circle,
                                              ),
                                              constraints: BoxConstraints(
                                                minWidth: 16.w,
                                                minHeight: 16.h,
                                              ),
                                              child: Text(
                                                '${post.comment!.length}', // Display the comment count
                                                style: TextStyle(
                                                  color: Colors.white,
                                                  fontSize: 10
                                                      .sp, // Smaller font size for the subscript
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                textAlign: TextAlign.center,
                                              ),
                                            ),
                                          ),
                                      ],
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
                                          arguments: post,
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              )
                            ],
                          ),
                        );
                      },
                    ),
                  ),
                );
              }
              return NoInternetConnectionWidget(
                onRetry: context.read<PostsCubit>().fetchAllPosts,
              );
            },
          ),
          BlocBuilder<PostsCubit, GenericState>(
            builder: (context, state) {
              return state.isSuccess
                  ? TextButton(
                      style: const ButtonStyle(
                          foregroundColor:
                              WidgetStatePropertyAll(AppColors.accentColor)),
                      child: const Text('See More'),
                      onPressed: () {
                        // handle see more action
                      },
                    )
                  : Container();
            },
          ),
        ],
      ),
    ));
  }

  void _showCommentSection(BuildContext context, MissingPersonEntity post) {
    showModalBottomSheet(
      useSafeArea: true,
      context: context,
      isScrollControlled: true,
      builder: (context) {
        return CommentSection(post: post); // Updated to pass the post
      },
    );
  }

  Widget _buildSearchResults(List<MissingPersonEntity> results) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      decoration: BoxDecoration(
        color: Colors.grey.shade200,
        // Subtle background for better separation
        borderRadius: BorderRadius.circular(8.0), // Gentle rounded corners
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 8.0), // Add some spacing after the heading
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: results.length,
            itemBuilder: (context, index) {
              final search = results[index];
              return InkWell(
                // Use InkWell for a more natural tap response
                borderRadius:
                    BorderRadius.circular(8.0), // Extend corner radius to items
                onTap: () {
                  Navigator.pushNamed(context, AppRoutes.MISSING_DETAIL,
                      arguments: search);
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 8.0),
                  child: Row(
                    children: [
                      Icon(
                        Icons.search_rounded, // Consistent material design icon
                        size: 20.0,
                        color: Theme.of(context)
                            .primaryColor, // Reflect theme color
                      ),
                      const SizedBox(
                          width: 8.0), // Spacing between icon and text
                      Flexible(
                        // Wrap text to avoid overflow on smaller screens
                        child: Text(
                          "${search.firstName} ${search.middleName} ${search.lastName}",
                          overflow:
                              TextOverflow.ellipsis, // Truncate long searches
                          style: const TextStyle(
                            fontSize: 14.0, // Clear item text size
                            color: Colors.black87, // Consistent text color
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}
