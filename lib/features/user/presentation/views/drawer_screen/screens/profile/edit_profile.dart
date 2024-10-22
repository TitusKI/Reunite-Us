import 'package:afalagi/core/constants/constant.dart';
import 'package:afalagi/core/resources/generic_state.dart';
import 'package:afalagi/features/user/presentation/bloc/profile_cubit.dart';
import 'package:afalagi/features/user/data/models/user_profile_model.dart';
import 'package:afalagi/config/theme/colors.dart';
import 'package:afalagi/features/auth/presentation/views/widgets/common_widgets.dart';
import 'package:afalagi/features/user/presentation/views/drawer_screen/widgets/success_dialog.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class EditProfileScreen extends StatefulWidget {
  const EditProfileScreen({super.key});

  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  // Controllers for managing text field inputs
  late TextEditingController _firstNameController;
  late TextEditingController _middleNameController;
  late TextEditingController _lastNameController;

  // @override
  // void initState() {
  //   super.initState();
  //   // Initialize ProfileCubit to load data if necessary
  //   context.read<ProfileCubit>().fetchProfile();
  // }

  // @override
  // void dispose() {
  //   // Clean up controllers
  //   _firstNameController.dispose();
  //   _middleNameController.dispose();
  //   _lastNameController.dispose();
  //   context.read<ProfileCubit>().close();
  //   super.dispose();
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarLarge("Edit Profile"),
      body: BlocBuilder<ProfileCubit, GenericState>(
        builder: (context, state) {
          if (state.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          // if (state.failure != null) {
          //   return Center(child: Text('Error: ${state.failure}'));
          // }

          final profile = state.data as UserProfile?;

          // Initialize controllers with the current profile data
          _initializeControllers(profile);

          return SingleChildScrollView(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 16.h),
              child: Column(
                children: [
                  _buildProfilePicture(profile),
                  SizedBox(height: 24.h),
                  _buildProfileFields(),
                  SizedBox(height: 24.h),
                  _buildUpdateButton(context),
                ],
              ),
            ),
          );
        },
      ),
    );
  }

  void _initializeControllers(UserProfile? profile) {
    _firstNameController =
        TextEditingController(text: profile?.firstName ?? '');
    _middleNameController =
        TextEditingController(text: profile?.middleName ?? '');
    _lastNameController = TextEditingController(text: profile?.lastName ?? '');
  }

  Widget _buildProfilePicture(UserProfile? profile) {
    final profilePictureUrl = profile != null
        ? '${AppConstant.UPLOAD_BASE_URL}/profile/${profile.profilePicture}'
        : '';

    return Column(
      children: [
        BlocBuilder<ProfileCubit, GenericState>(
          builder: (context, state) {
            final imagePath = state.imageFile;
            return CircleAvatar(
              radius: 40.r,
              backgroundColor: AppColors.primaryBackground,
              foregroundImage: imagePath != null
                  ? FileImage(imagePath)
                  : profile?.profilePicture != null
                      ? NetworkImage(profilePictureUrl)
                      : const AssetImage('assets/icons/user.png')
                          as ImageProvider,
            );
          },
        ),
        SizedBox(height: 8.h),
        TextButton(
          onPressed: () {
            // Handle change picture button press
            context.read<ProfileCubit>().pickImage();
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
        SizedBox(
          height: 8.h,
        ),
        BlocBuilder<ProfileCubit, GenericState>(
          builder: (context, state) {
            final imagePath = state.imageFile;
            if (profile?.profilePicture != null || imagePath != null) {
              return TextButton(
                onPressed: () {
                  context.read<ProfileCubit>().deleteProfilePicture();
                },
                child: Text(
                  'Delete Picture',
                  style: TextStyle(
                    color: Colors.red,
                    fontSize: 16.sp,
                    decoration: TextDecoration.underline,
                  ),
                ),
              );
            } else {
              return const SizedBox.shrink();
            }
          },
        ),
      ],
    );
  }

  Widget _buildProfileFields() {
    return Column(
      children: [
        _buildTextField(controller: _firstNameController, label: 'First Name'),
        SizedBox(height: 16.h),
        _buildTextField(
            controller: _middleNameController, label: 'Middle Name'),
        SizedBox(height: 16.h),
        _buildTextField(controller: _lastNameController, label: 'Last Name'),
        SizedBox(height: 16.h),
      ],
    );
  }

  Widget _buildTextField(
      {required TextEditingController controller,
      required String label,
      TextInputType keyboardType = TextInputType.text}) {
    return TextField(
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        labelText: label,
        labelStyle: TextStyle(fontSize: 16.sp, color: AppColors.secondaryColor),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8.r),
        ),
      ),
      style: TextStyle(
        fontSize: 16.sp,
      ),
    );
  }

  Widget _buildUpdateButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.accentColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
          padding: EdgeInsets.symmetric(vertical: 12.h),
        ),
        onPressed: () => _submitProfileUpdate(context),
        child: Text(
          'Update',
          style: TextStyle(fontSize: 18.sp, color: AppColors.primaryBackground),
        ),
      ),
    );
  }

  void _submitProfileUpdate(BuildContext context) async {
    // Gather profile updates
    final updates = {
      'firstName': _firstNameController.text,
      'middleName': _middleNameController.text,
      'lastName': _lastNameController.text,
    };

    // Fetch the updated profile image from ProfileCubit
    final imageFile = context.read<ProfileCubit>().state.imageFile;

    // If an image was picked, update the profile picture as well
    if (imageFile != null) {
      FormData formData = FormData.fromMap({
        'profilePicture': await MultipartFile.fromFile(imageFile.path),
      });

      context.read<ProfileCubit>().updateProfilePicture(formData).then((_) {
        _updateUserDetails(
            context, updates); // Proceed with updating the rest of the profile
      }).catchError((error) {
        _handleProfileUpdateError(
            context, 'Failed to update profile picture: $error');
      });
    } else {
      // No image picked, proceed with just updating the profile details
      _updateUserDetails(context, updates);
    }
  }

// Helper function to update user profile details
  void _updateUserDetails(BuildContext context, Map<String, String> updates) {
    context.read<ProfileCubit>().updateUserProfile(updates).then((_) {
      showDialog(
        context: context,
        builder: (context) => const UpdateSuccessDialog(),
      );
    }).catchError((error) {
      _handleProfileUpdateError(
          context, 'Failed to update profile details: $error');
    });
  }

// Helper function to handle errors during profile update
  void _handleProfileUpdateError(BuildContext context, String errorMessage) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(errorMessage)),
    );
  }
}
