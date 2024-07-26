import 'package:afalagi/routes/export.dart';
import 'package:afalagi/views/common/values/colors.dart';
import 'package:afalagi/views/common/widgets/common_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileDetail extends StatelessWidget {
  const ProfileDetail({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarLarge("Profile Details"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Profile picture
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: CircleAvatar(
                radius: 60.r,
                backgroundImage: const AssetImage(
                    'assets/temp/foundMan.jpg'), // replace with actual image path
              ),
            ),
            // User name
            Text(
              'Leulseged Lema', // replace with actual user name
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor,
              ),
            ),
            // User details
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow(Icons.person, 'Name', 'Leulseged Lema'),
                  _buildDetailRow(Icons.cake, 'Age', '21'),
                  _buildDetailRow(Icons.phone, 'Contact', '+251 912345678'),
                  _buildDetailRow(Icons.email, 'Email', 'leulseged@gmail.com'),
                ],
              ),
            ),
            // Send Message button
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: ElevatedButton(
                style: ButtonStyle(
                  backgroundColor:
                      const WidgetStatePropertyAll(AppColors.accentColor),
                  padding: WidgetStatePropertyAll(
                      EdgeInsets.symmetric(horizontal: 40.w, vertical: 12.h)),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.CHAT_PAGE);
                  // handle send message action
                  // _sendMessage(context);
                },
                child: Text(
                  'Send Message',
                  style: TextStyle(
                      fontSize: 16.sp, color: AppColors.primaryBackground),
                ),
              ),
            ),
            // Description
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.h),
              child: Text(
                'My Sister has been missing since 2021. If you have any information, please contact the provided phone number or email.',
                style: TextStyle(
                    fontSize: 16.sp, color: AppColors.primarySecondaryText),
                textAlign: TextAlign.center,
              ),
            ),
          ],
        ),
      ),
    );
  }

  // Widget to build individual detail rows
  Widget _buildDetailRow(IconData icon, String title, String detail) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Row(
        children: [
          Icon(icon, color: AppColors.secondaryColor),
          SizedBox(width: 10.w),
          Text(
            '$title: ',
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: AppColors.secondaryColor,
            ),
          ),
          Expanded(
            child: Text(detail),
          ),
        ],
      ),
    );
  }

  // Method to show message dialog
  void _sendMessage(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Send Message'),
          content: TextField(
            decoration: InputDecoration(
              hintText: 'Type your message here',
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.r),
              ),
            ),
            maxLines: 5,
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                // handle send message action
                Navigator.of(context).pop();
              },
              child: const Text('Send'),
            ),
          ],
        );
      },
    );
  }
}
