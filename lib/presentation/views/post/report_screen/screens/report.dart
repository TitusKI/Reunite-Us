import 'package:afalagi/core/constants/domain_export.dart';
import 'package:afalagi/core/constants/presentation_export.dart';
import 'package:afalagi/domain/entities/success_story/success_story_entity.dart';

import 'package:afalagi/presentation/bloc/success_story/success_story_cubit.dart';

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
        }
        // else if (state.failure != null) {
        //   return Center(
        //       child: Text(
        //           'Failed to load missing person posts${state.failure.toString}'));
        // }
        else if (state.data != null) {
          final posts = state.data as List<MissingPersonEntity>;
          return ListView.builder(
            itemCount: posts.length,
            itemBuilder: (context, index) {
              final post = posts[index];
              return Card(
                margin: const EdgeInsets.all(8.0),
                child: InkResponse(
                  onTap: () {
                    Navigator.pushNamed(context, AppRoutes.MISSING_DETAIL,
                        arguments: post);
                  },
                  child: ListTile(
                    title: Text(
                        '${post.firstName} ${post.middleName} ${post.lastName}'),
                    subtitle: Text(post.description),
                    trailing: PopupMenuButton(
                      icon: const Icon(Icons.more_vert),
                      itemBuilder: (context) => [
                        const PopupMenuItem(
                          value: 'edit',
                          child: Text('Edit'),
                        ),
                        const PopupMenuItem(
                          value: 'close',
                          child: Text('Close Post'),
                        ),
                        const PopupMenuItem(
                          value: 'delete',
                          child: Text('Delete Post'),
                        ),
                      ],
                      onSelected: (value) {
                        switch (value) {
                          case 'edit':
                            Navigator.pushNamed(
                              context,
                              AppRoutes.HOME,
                              arguments: post,
                            );
                            break;
                          case 'close':
                            Navigator.pushNamed(
                                context, AppRoutes.CLOSE_REPORT);

                            break;
                          case 'delete':
                            context.read<PostsCubit>().deletePost(post.id!);
                            break;
                        }
                      },
                    ),
                  ),
                ),
              );
            },
          );
        } else {
          return const Center(child: Text("No posts found."));
        }
      },
    );
  }
}
