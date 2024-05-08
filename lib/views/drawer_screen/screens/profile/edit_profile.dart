import 'package:afalagi/views/common/values/colors.dart';
import 'package:afalagi/views/common/widgets/common_widgets.dart';
import 'package:afalagi/views/drawer_screen/widgets/success_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarLarge("Edit Profile"),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
          child: Column(
            children: [
              CircleAvatar(
                radius: 50.r,
                backgroundImage: const AssetImage(
                    'assets/temp/brotherOfMissing.jpg'), // Replace with actual image path
              ),
              SizedBox(height: 8.h),
              TextButton(
                onPressed: () {
                  // Handle change picture button press
                },
                child: Text(
                  'Change Picture',
                  style: TextStyle(
                    color: const Color(0xFF1E88E5),
                    fontSize: 16.sp,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
              SizedBox(height: 24.h),
              buildTextField(
                  label: 'First Name',
                  initialValue: 'Kidanemariam',
                  context: context),
              SizedBox(height: 16.h),
              buildTextField(
                  label: 'Middle Name',
                  initialValue: 'Mazengiaw',
                  context: context),
              SizedBox(height: 16.h),
              buildTextField(
                  label: 'Last Name', initialValue: 'Bezie', context: context),
              SizedBox(height: 16.h),
              buildTextField(
                  label: 'Email',
                  initialValue: 'kidu@@gmail.com',
                  context: context,
                  keyboardType: TextInputType.emailAddress),
              SizedBox(height: 16.h),
              buildTextField(
                  label: 'Phone Number',
                  initialValue: '+251 999999999',
                  context: context,
                  keyboardType: TextInputType.phone),
              SizedBox(height: 24.h),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.accentColor,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.r),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                  ),
                  onPressed: () {
                    showDialog(
                        context: context,
                        builder: (context) => const UpdateSuccessDialog());
                  },
                  child: Text(
                    'Update',
                    style: TextStyle(
                        fontSize: 18.sp, color: AppColors.primaryBackground),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget buildTextField(
      {required String label,
      required String initialValue,
      required BuildContext context,
      TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      keyboardType: keyboardType,
      decoration: InputDecoration(
        focusColor: AppColors.secondaryColor,
        labelText: label,
        labelStyle: TextStyle(fontSize: 16.sp, color: AppColors.secondaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      style: TextStyle(
        fontSize: 16.sp,
      ),
      controller: TextEditingController()..text = initialValue,
    );
  }
}
