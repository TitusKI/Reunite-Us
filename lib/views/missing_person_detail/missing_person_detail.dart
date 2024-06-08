import 'package:afalagi/views/common/values/colors.dart';
import 'package:afalagi/views/common/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MissingPersonDetail extends StatefulWidget {
  const MissingPersonDetail({super.key});

  @override
  State<MissingPersonDetail> createState() => _MissingPersonDetailState();
}

class _MissingPersonDetailState extends State<MissingPersonDetail> {
  // @override
  // void dispose() {
  //   _controller.dispose();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarLarge("Missing Person Details"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // Missing person picture
            Padding(
              padding: EdgeInsets.symmetric(vertical: 20.h),
              child: CircleAvatar(
                radius: 60.r,
                backgroundImage: const AssetImage(
                    'assets/temp/missingWoman.jpg'), // replace with actual image path
              ),
            ),
            // Missing person name
            Text(
              'Lielt Leulseged Lema', // replace with actual missing person's name
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor,
              ),
            ),
            // Missing person details
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildDetailRow(Icons.cake, 'Age', '21'),
                  _buildDetailRow(
                      Icons.location_on, 'Last known location', 'Bole Airport'),
                  _buildDetailRow(Icons.calendar_today, 'Date', '10 June 2014'),
                  _buildDetailRow(Icons.description, 'Description',
                      'Lielt was last seen wearing a white dress and a red scarf. She is 5\'6" tall and has black hair.'),
                ],
              ),
            ),
            // Videos section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Videos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    color: AppColors.secondaryColor,
                  ),
                ),
              ),
            ),
            // _buildVideoPlayer(),
            // Photos section
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.h),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Photos',
                  style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 18.sp,
                    color: AppColors.secondaryColor,
                  ),
                ),
              ),
            ),
            _buildPhotosGrid(),
            // Description
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.h),
              child: Text(
                'Lielt Leulseged Lema was last seen at Bole Airport on 10 June 2014. She was wearing a white dress and a red scarf. If you have any information, please contact the provided phone number or email.',
                style: TextStyle(
                    fontSize: 16.sp, color: AppColors.primarySecondaryText),
                textAlign: TextAlign.center,
              ),
            ),
            // Contact button
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
                  // handle contact action
                  _showContactOptions(context);
                },
                child: Text(
                  'Contact',
                  style: TextStyle(
                      fontSize: 16.sp, color: AppColors.primaryBackground),
                ),
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

  // Widget to build the video player
  // Widget _buildVideoPlayer() {
  //   return Padding(
  //     padding: EdgeInsets.all(16.0.w),
  //     child: _controller.value.isInitialized
  //         ? AspectRatio(
  //             aspectRatio: _controller.value.aspectRatio,
  //             child: VideoPlayer(_controller),
  //           )
  //         : const CircularProgressIndicator(),
  //   );
  // }

  // Widget to build the photos grid
  Widget _buildPhotosGrid() {
    return Padding(
      padding: EdgeInsets.all(16.0.w),
      child: GridView.builder(
        physics:
            const NeverScrollableScrollPhysics(), // to prevent GridView from scrolling
        shrinkWrap: true,
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 10.w,
          mainAxisSpacing: 10.h,
        ),
        itemCount: 4, // replace with the actual number of photos
        itemBuilder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10.r),
              image: const DecorationImage(
                image: AssetImage(
                    'assets/temp/missingWoman.jpg'), // replace with actual image path
                fit: BoxFit.cover,
              ),
            ),
          );
        },
      ),
    );
  }

  // Method to show contact options
  void _showContactOptions(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Contact Options'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.phone),
                title: const Text('Call'),
                onTap: () {
                  // handle call action
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.email),
                title: const Text('Email'),
                onTap: () {
                  // handle email action
                  Navigator.of(context).pop();
                },
              ),
              ListTile(
                leading: const Icon(Icons.message),
                title: const Text('Message'),
                onTap: () {
                  // handle message action
                  Navigator.of(context).pop();
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text('Cancel'),
            ),
          ],
        );
      },
    );
  }
}
