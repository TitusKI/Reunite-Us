import 'package:afalagi/config/theme/colors.dart';
import 'package:afalagi/features/auth/presentation/views/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarLarge("About Us"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(12.0.r),
                child: Image.asset(
                  'assets/logo/logo.png', // Replace with Afalagi's logo
                  height: 150.h,
                  width: 150.w,
                  fit: BoxFit.fill,
                ),
              ),
            ),
            SizedBox(height: 20.0.h),
            Text(
              'Our Mission',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor,
              ),
            ),
            SizedBox(height: 10.0.h),
            Text(
              'At Reunite-Us, our mission is to provide comprehensive services to help reunite lost individuals with their families and loved ones. We aim to offer support, resources, and hope to those in need.',
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 20.0.h),
            Text(
              'Our Vision',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor,
              ),
            ),
            SizedBox(height: 10.0.h),
            Text(
              'Our vision is to create a world where no one remains lost. We strive to leverage technology and community efforts to ensure that every missing person is found and safely reunited with their families.',
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 20.0.h),
            Text(
              'Our Values',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor,
              ),
            ),
            SizedBox(height: 10.0.h),
            Text(
              'Compassion: We care deeply about the well-being of missing persons and their families.\n\n'
              'Integrity: We operate with honesty and transparency in all our efforts.\n\n'
              'Collaboration: We believe in the power of working together with communities and other organizations.\n\n'
              'Innovation: We continuously seek new ways to improve our services and expand our reach.',
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 20.0.h),
            Text(
              'Meet Our Team',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor,
              ),
            ),
            SizedBox(height: 10.0.h),
            // Example Team Member
            buildTeamMember(
              'Kidanemariam Mazengiaw',
              'Founder & CEO',
              'assets/temp/kidan.jpg', // Replace with actual image
            ),
            buildTeamMember(
              'Kaleab Solomon',
              'CTO',
              'assets/temp/kaleab.jpeg', // Replace with actual image
            ),
            buildTeamMember(
              'John Assefa',
              'Head of Operations',
              'assets/temp/John.jpeg', // Replace with actual image
            ),
            buildTeamMember(
              'Tsegaye Talegngeta',
              'Project Manager',
              'assets/temp/Tsegaye.jpg', // Replace with actual image
            ),
            SizedBox(height: 20.0.h),
            Text(
              'Contact Us',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor,
              ),
            ),
            SizedBox(height: 10.0.h),
            Text(
              'Email: info@afalagi.com\nPhone: +251-123-456-789\nAddress: Merkato, Teklehaymanot, Addis Ababa, Ethiopia',
              style: TextStyle(fontSize: 16.sp),
            ),
          ],
        ),
      ),
    );
  }

  Widget buildTeamMember(String name, String position, String imagePath) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.0.h),
      child: Row(
        children: [
          ClipRRect(
            borderRadius: BorderRadius.circular(50.0.r),
            child: Image.asset(
              imagePath,
              height: 50.h,
              width: 50.w,
              fit: BoxFit.cover,
            ),
          ),
          SizedBox(width: 10.0.w),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                name,
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
              Text(
                position,
                style: TextStyle(fontSize: 16.sp, color: Colors.grey[600]),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
