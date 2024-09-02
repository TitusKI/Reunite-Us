import 'package:afalagi/config/theme/colors.dart';
import 'package:afalagi/core/constants/constant.dart';
import 'package:afalagi/core/constants/presentation_export.dart';
import 'package:afalagi/domain/entities/success_story/success_story_entity.dart';
import 'package:afalagi/presentation/bloc/generic_state.dart';
import 'package:afalagi/presentation/bloc/success_story/success_story_cubit.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FoundPersons extends StatefulWidget {
  const FoundPersons({super.key});

  @override
  State<FoundPersons> createState() => _FoundPersonsState();
}

class _FoundPersonsState extends State<FoundPersons> {
  @override
  void initState() {
    super.initState();
    // Fetch success stories when the widget is initialized
    context.read<SuccessStoryCubit>().getSuccessStories();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SuccessStoryCubit, GenericState>(
      builder: (context, state) {
        if (state.isLoading) {
          return Center(
            child: Container(),
          );
        }

        if (state.failure != null) {
          Navigator.pushNamed(context, AppRoutes.HOME);
        }

        final List<SuccessStoryEntity> successStories = state.data ?? [];

        if (successStories.isEmpty) {
          return const Center(
            child: Text('No success stories found.'),
          );
        }

        return ListView.builder(
          itemCount: successStories.length,
          itemBuilder: (context, index) {
            final story = successStories[index];
            final user = story.user;
            final profile = user!.profile;
            final profilePictureUrl =
                '${AppConstant.UPLOAD_BASE_URL}/profile/${profile.profilePicture}';
            final storyPictureUrl =
                '${AppConstant.UPLOAD_BASE_URL}/post/${story.images![0]}';
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Card(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Column(
                    children: [
                      ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            profilePictureUrl, // Ensure image URL is correct
                          ),
                        ),
                        title: Text(
                          "${profile.firstName} ${profile.middleName} ",
                          style: const TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 16.0,
                            color: AppColors.secondaryColor,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10.0),
                      Text(
                        story.content!,
                        style: const TextStyle(
                            fontSize: 14.0, color: AppColors.secondaryColor),
                      ),
                      const SizedBox(height: 10.0),
                      if (storyPictureUrl.isNotEmpty) // Check if image exists
                        Row(
                          children: [
                            Expanded(
                              child: Image.network(
                                storyPictureUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ],
                        ),
                      const SizedBox(height: 10.0),
                      const Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'Watch the story on',
                            style:
                                TextStyle(fontSize: 14.0, color: Colors.blue),
                          ),
                        ],
                      ),
                      const SizedBox(height: 10.0),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          _buildSocialMediaButton(
                            Icons.video_library,
                            'YouTube',
                            Colors.red,
                          ),
                          const SizedBox(width: 10.0),
                          _buildSocialMediaButton(
                            Icons.facebook,
                            'Facebook',
                            AppColors.accentColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            );
          },
        );
      },
    );
  }

  Widget _buildSocialMediaButton(IconData icon, String label, Color color) {
    return TextButton.icon(
      onPressed: () {
        // Handle button press
      },
      icon: Icon(icon, color: color),
      label: Text(label, style: TextStyle(color: color)),
    );
  }
}
