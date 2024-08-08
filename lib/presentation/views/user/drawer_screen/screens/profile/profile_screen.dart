import 'package:afalagi/core/constants/constant.dart';
import 'package:afalagi/presentation/bloc/generic_state.dart';
import 'package:afalagi/presentation/bloc/user/profile/profile_cubit.dart';
import 'package:afalagi/data/models/user/user_profile_model.dart';
import 'package:afalagi/core/constants/presentation_export.dart';
import 'package:afalagi/config/theme/colors.dart';
import 'package:afalagi/presentation/views/common/widgets/common_widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    // final profileCubit = context.watch<ProfileCubit>();
    // final profile = profileCubit.state.data;
    return Scaffold(
      appBar: buildAppBarLarge("Profile"),
      body: Center(
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 16.w),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(height: 30.h),
              BlocBuilder<ProfileCubit, GenericState>(
                  builder: (context, state) {
                if (state.isLoading) {
                  return const Center(child: CircularProgressIndicator());
                }
                final profile = state.data as UserProfile?;
                print("Display on the Drawer");
                print(profile);
                final profilePictureUrl = profile != null
                    ? '${AppConstant.UPLOAD_BASE_URL}/profile/${profile.profilePicture}'
                    : '';
                return CircleAvatar(
                  backgroundColor: AppColors.primaryBackground,
                  backgroundImage: profile?.profilePicture != null
                      ? NetworkImage(profilePictureUrl)
                      : const AssetImage('assets/icons/user.png')
                          as ImageProvider,
                );
              }),
              SizedBox(height: 16.h),
              TextButton(
                style: TextButton.styleFrom(
                  backgroundColor: AppColors.accentColor,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8.r),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(AppRoutes.EDIT_PROFILE);
                  // Handle edit profile button press
                },
                child: Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 20.w, vertical: 10.h),
                  child: Text(
                    'Edit Profile',
                    style: TextStyle(color: Colors.white, fontSize: 16.sp),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
