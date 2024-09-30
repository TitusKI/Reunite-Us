import 'package:afalagi/config/theme/colors.dart';
import 'package:afalagi/core/constants/domain_export.dart';
import 'package:afalagi/core/constants/presentation_export.dart';
import 'package:afalagi/features/post/presentation/views/report_screen/screens/close_post.dart';
import 'package:afalagi/features/success_stories/domain/entities/success_story_entity.dart';

import 'package:afalagi/features/success_stories/presentation/bloc/success_story_cubit.dart';

class ReportMissing extends StatefulWidget {
  const ReportMissing({super.key});

  @override
  State<ReportMissing> createState() => _ReportMissingState();
}

class _ReportMissingState extends State<ReportMissing>
    with SingleTickerProviderStateMixin {
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this);
    // Fetch success stories and posts once the screen is initialized
    context.read<SuccessStoryCubit>().getSuccessStories();
    context.read<PostsCubit>().fetchMyPosts();
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: TabBar(
        controller: _tabController,
        tabs: const [
          Tab(text: "My Posts"),
          Tab(text: "My Success Stories"),
        ],
      ),
      body: TabBarView(
        controller: _tabController,
        children: [
          _buildMyPostsSection(),
          _buildMySuccessStoriesSection(),
        ],
      ),
    );
  }

  // My Success Stories Tab
  Widget _buildMySuccessStoriesSection() {
    return BlocBuilder<SuccessStoryCubit, GenericState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }
        // else if (state.failure != null) {
        //   return Center(
        //       child: Text(
        //           'Failed to load success stories${state.failure.toString()}'));
        // }
        else if (state.data != null) {
          final stories = state.data as List<SuccessStoryEntity>;
          return ListView.builder(
            itemCount: stories.length,
            itemBuilder: (context, index) {
              final story = stories[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: ListTile(
                  title: Text(story.title!),
                  subtitle: Text(story.content!),
                  trailing: IconButton(
                    icon: const Icon(Icons.delete),
                    onPressed: () {
                      context
                          .read<SuccessStoryCubit>()
                          .removeSuccessStory(story);
                    },
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: Text("No success stories found."));
        }
      },
    );
  }

  // My Posts Tab (Missing Person Posts)

  Widget _buildMyPostsSection() {
    return BlocBuilder<PostsCubit, GenericState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state.data != null) {
          final posts = state.data as List<MissingPersonEntity>;

          // Group posts by status
          final openPosts =
              posts.where((post) => post.status == "OPEN").toList();
          print('List of Open Posts');
          print(openPosts[1].status);
          final pendingPosts =
              posts.where((post) => post.status == "UNDER_REVIEW").toList();
          print('List of Pending Posts');
          print(openPosts.length);
          final closedPosts =
              posts.where((post) => post.status == "CLOSED").toList();
          print('List of closed Posts');
          print(closedPosts.length);
          final deletedPosts =
              posts.where((post) => post.status == "REMOVED").toList();
          print('List of deleted Posts');
          print(deletedPosts.length);
          final rejectedPosts =
              posts.where((post) => post.status == "REJECTED").toList();
          print('List of Rejected Posts');
          print(rejectedPosts.length);

          return ListView(
            children: [
              _buildPostSection("Open Posts", openPosts, context),
              _buildPostSection("Pending Posts", pendingPosts, context),
              _buildPostSection("Closed Posts", closedPosts, context),
              _buildPostSection("Deleted Posts", deletedPosts, context),
              _buildPostSection("Rejected Posts", rejectedPosts, context),
            ],
          );
        } else {
          return _buildEmptyPostsUI(context);
        }
      },
    );
  }

  Widget _buildPostSection(
      String title, List<MissingPersonEntity> posts, BuildContext context) {
    if (posts.isEmpty) return const SizedBox.shrink();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Text(
              title,
              style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: AppColors.primaryText),
            ),
          ),
          ListView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Card(
                margin:
                    const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
                child: InkResponse(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.MISSING_DETAIL,
                        arguments: post);
                  },
                  child: ListTile(
                    title: Text(
                        '${post.firstName} ${post.middleName} ${post.lastName}'),
                    subtitle: Text(post.description),
                    trailing: _buildPopupMenu(context, post),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  PopupMenuButton _buildPopupMenu(
      BuildContext context, MissingPersonEntity post) {
    List<PopupMenuEntry<String>> menuItems = [];

    if (post.status == 'OPEN') {
      menuItems.add(const PopupMenuItem(value: 'edit', child: Text('Edit')));
      menuItems
          .add(const PopupMenuItem(value: 'close', child: Text('Close Post')));
      menuItems.add(
          const PopupMenuItem(value: 'delete', child: Text('Delete Post')));
    }
    // else if (post.status == PostStatus.UNDER_REVIEW) {
    //   menuItems.add(
    //       const PopupMenuItem(value: 'review', child: Text('Under Review')));
    // } else if (post.status == PostStatus.CLOSED) {
    //   menuItems.add(
    //       const PopupMenuItem(value: 'view', child: Text('View Closed Post')));
    // } else if (post.status == PostStatus.REMOVED) {
    //   menuItems.add(
    //       const PopupMenuItem(value: 'deleted', child: Text('Removed Post')));
    // } else if (post.status == PostStatus.REJECTED) {
    //   menuItems.add(
    //       const PopupMenuItem(value: 'rejected', child: Text('Rejected Post')));
    // }

    return PopupMenuButton<String>(
      icon: const Icon(Icons.more_vert),
      itemBuilder: (context) => menuItems,
      onSelected: (value) {
        switch (value) {
          case 'edit':
            Navigator.pushNamed(context, AppRoutes.ADD_REPORT, arguments: post);
            break;
          case 'close':
            showClosePostDialog(context, postId: post.id!);
            break;
          case 'delete':
            context.read<PostsCubit>().deletePost(post.id!);
            break;
        }
      },
    );
  }

  Widget _buildEmptyPostsUI(BuildContext context) {
    final height = MediaQuery.of(context).size.height;
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const SizedBox(height: 5.0),
          Container(
            height: height * 0.2,
            decoration: const BoxDecoration(
                shape: BoxShape.circle, color: AppColors.cardColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Icon(Icons.no_luggage_outlined, size: 35),
                const SizedBox(height: 5.0),
                Text("No Posts",
                    style: TextStyle(fontSize: 18, color: Colors.grey[700])),
              ],
            ),
          ),
          const SizedBox(height: 20.0),
          Text("You don't have any previous posts.",
              style: TextStyle(fontSize: 18, color: Colors.grey[600]),
              textAlign: TextAlign.center),
          const SizedBox(height: 10),
          Text("If you have a missing person, post now!",
              style: TextStyle(fontSize: 16, color: Colors.grey[600]),
              textAlign: TextAlign.center),
          const SizedBox(height: 30),
          ElevatedButton.icon(
            onPressed: () =>
                Navigator.of(context).pushNamed(AppRoutes.ADD_REPORT),
            icon: const Icon(Icons.add),
            label: const Text("Post Missing Person"),
            style: ElevatedButton.styleFrom(
              foregroundColor: AppColors.primaryBackground,
              backgroundColor: AppColors.accentColor,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
              textStyle: const TextStyle(fontSize: 16),
            ),
          ),
        ],
      ),
    );
  }
}

Future<void> showClosePostDialog(BuildContext context,
    {required String postId}) async {
  showDialog(
    context: context,
    builder: (context) => ClosePostScreen(postId: postId),
  );
}
