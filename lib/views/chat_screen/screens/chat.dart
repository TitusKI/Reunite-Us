import 'package:afalagi/routes/export.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ChatScreen extends StatefulWidget {
  const ChatScreen({super.key});

  @override
  State<ChatScreen> createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(16.0.w),
      child: Column(
        children: [
          // Search Bar
          Container(
            padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.0.h),
            decoration: BoxDecoration(
              color: Colors.grey[200],
              borderRadius: BorderRadius.circular(20.0),
            ),
            child: Row(
              children: [
                const Icon(Icons.search, color: Colors.grey),
                SizedBox(width: 10.0.w),
                const Expanded(
                  child: TextField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: 'Search',
                    ),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0.h),
          // List of User Cards
          Expanded(
            child: ListView(
              children: [
                _buildUserCard(
                    'assets/temp/reunitedFriend1.jpg', // Replace with correct image path
                    'Kyle Johnsen',
                    'Do you find your Boy?',
                    func: () =>
                        Navigator.of(context).pushNamed(AppRoutes.CHAT_PAGE)),
                _buildUserCard(
                  'assets/temp/marriedReunited.jpg', // Replace with correct image path
                  'Surafel Abihot',
                  'Are you coming to the meeting?',
                ),
                _buildUserCard(
                  'assets/temp/reunitedFriends2.jpg', // Replace with correct image path
                  'Titisha Jemberu',
                  "Let's catch up soon!",
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildUserCard(String imagePath, String name, String message,
      {void Function()? func}) {
    return GestureDetector(
      onTap: func,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),
        margin: EdgeInsets.symmetric(vertical: 8.0.h),
        child: ListTile(
          contentPadding: EdgeInsets.all(8.0.w),
          leading: CircleAvatar(
            radius: 30.0.r,
            backgroundImage: AssetImage(imagePath),
          ),
          title: Text(
            name,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 16.0.sp,
            ),
          ),
          subtitle: Text(
            message,
            style: TextStyle(
              fontSize: 14.0.sp,
              color: Colors.grey[600],
            ),
          ),
        ),
      ),
    );
  }
}
