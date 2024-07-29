import 'package:afalagi/views/common/values/colors.dart';
import 'package:flutter/material.dart';

class FoundPersons extends StatefulWidget {
  const FoundPersons({super.key});

  @override
  State<FoundPersons> createState() => _FoundPersonsState();
}

class _FoundPersonsState extends State<FoundPersons> {
  final List<Map<String, String>> stories = [
    {
      'name': 'Kyle Johnsen',
      'image':
          'assets/temp/reunitedFriend1.jpg', // Replace with actual image path
      'story':
          'After years of searching, I finally found my brother. Our reunion was filled with tears of joy and heartfelt thanks.',
      'youtube': 'youtube',
      'facebook': 'facebook',
    },
    {
      'name': 'Peter Stephen',
      'image':
          'assets/temp/marriedReunited.jpg', // Replace with actual image path
      'story':
          'I and Mary were separated for a decade. Our emotional reunion brought smiles and happy tears to everyone around.',
      'youtube': 'youtube',
      'facebook': 'facebook',
    },
    {
      'name': 'Erbka Leul',
      'image':
          'assets/temp/reunitedFriends2.jpg', // Replace with actual image path
      'story':
          'I finally found my best friend after years apart. Our reunion was filled with laughter and endless conversations.',
      'youtube': 'youtube',
      'facebook': 'facebook',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: stories.length,
      itemBuilder: (context, index) {
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
                      backgroundImage: AssetImage(stories[index]['image']!),
                    ),
                    title: Text(
                      stories[index]['name']!,
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16.0,
                        color: AppColors.secondaryColor,
                      ),
                    ),
                  ),
                  const SizedBox(height: 10.0),
                  Text(
                    stories[index]['story']!,
                    style: const TextStyle(
                        fontSize: 14.0, color: AppColors.secondaryColor),
                  ),
                  const SizedBox(height: 10.0),
                  Row(
                    children: [
                      Expanded(
                        child: Image.asset(
                          stories[index]['image']!,
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
                        style: TextStyle(fontSize: 14.0, color: Colors.blue),
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
  }

  Widget _buildSocialMediaButton(IconData icon, String label, Color color) {
    return TextButton.icon(
      onPressed: () {},
      icon: Icon(icon, color: color),
      label: Text(label, style: TextStyle(color: color)),
    );
  }
}
