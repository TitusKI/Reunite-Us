import 'package:afalagi/config/theme/colors.dart';
import 'package:afalagi/presentation/views/common/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SupportDonationPage extends StatelessWidget {
  const SupportDonationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarLarge("Support and Donation"),
      body: SingleChildScrollView(
        padding: EdgeInsets.all(16.0.w),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 20.0.h),
            Text(
              'Support Our Cause',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor,
              ),
            ),
            SizedBox(height: 10.0.h),
            Text(
              'At Afalagi, we rely on your generous support to help reunite lost individuals with their families. Your donations enable us to provide vital services and resources to those in need.',
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 20.0.h),
            Text(
              'How Your Donation Helps',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor,
              ),
            ),
            SizedBox(height: 10.0.h),
            Text(
              '• Supporting search and rescue operations.\n'
              '• Providing resources and assistance to families.\n'
              '• Enhancing our technological capabilities to track and locate missing persons.\n'
              '• Creating awareness campaigns to prevent disappearances.',
              style: TextStyle(fontSize: 16.sp),
            ),
            SizedBox(height: 20.0.h),
            Text(
              'Make a Donation',
              style: TextStyle(
                fontSize: 24.sp,
                fontWeight: FontWeight.bold,
                color: AppColors.secondaryColor,
              ),
            ),
            SizedBox(height: 10.0.h),
            Center(
              child: ElevatedButton.icon(
                onPressed: () {
                  // Implement Chappa payment integration here
                },
                icon: const Icon(Icons.payment),
                label: Text(
                  'Donate with Chappa',
                  style: TextStyle(fontSize: 18.sp),
                ),
                style: ElevatedButton.styleFrom(
                  foregroundColor: AppColors.primaryBackground,
                  padding: EdgeInsets.symmetric(
                      horizontal: 20.0.w, vertical: 12.0.h),
                  backgroundColor: AppColors.accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(30.0.r),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0.h),
            Center(
              child: Text(
                'Thank you for your support!',
                style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
