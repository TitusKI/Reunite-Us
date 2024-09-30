import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../config/theme/colors.dart';
import '../../../../../../core/constants/constant.dart';
import '../../../../../../core/constants/presentation_export.dart';
import '../../../../data/models/user_profile_model.dart';
import '../widgets/animated_theme.dart';
import '../widgets/show_dialog.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  late ProfileCubit _cubit;

  @override
  void initState() {
    super.initState();
    _cubit = context.read<ProfileCubit>();
    _cubit.fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final isDarkMode = themeCubit.state.brightness == Brightness.dark;

    return BlocBuilder<ProfileCubit, GenericState>(
      builder: (context, state) {
        final profile = state.data as UserProfile?;
        final profilePictureUrl = profile != null
            ? '${AppConstant.UPLOAD_BASE_URL}/profile/${profile.profilePicture}'
            : '';

        return Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              UserAccountsDrawerHeader(
                decoration: const BoxDecoration(
                  color: AppColors.secondaryColor,
                  image: DecorationImage(
                    opacity: 0.5,
                    image: AssetImage('assets/logo/logo.png'),
                    fit: BoxFit.cover,
                  ),
                ),
                accountName: Text(
                  profile?.firstName ?? 'Guest',
                  style: const TextStyle(
                    color: AppColors.primaryBackground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  profile?.email ?? 'welcome!',
                  style: const TextStyle(
                    color: AppColors.primaryBackground,
                  ),
                ),
                currentAccountPicture: GestureDetector(
                  onTap: () {
                    if (profile != null) {
                      Navigator.of(context).pushNamed(AppRoutes.PROFILE);
                    }
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.primaryBackground,
                    backgroundImage: profile?.profilePicture != null
                        ? NetworkImage(profilePictureUrl)
                        : const AssetImage('assets/icons/user.png')
                            as ImageProvider,
                  ),
                ),
                otherAccountsPictures: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        themeCubit.toggleTheme();
                      });
                    },
                    child: AnimatedMoonSunIcon(
                        isDarkMode:
                            themeCubit.state.brightness == Brightness.dark),
                  ),
                ],
              ),
              ListTile(
                iconColor: AppColors.secondaryColor,
                splashColor: AppColors.accentColor,
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.SETTING);
                },
              ),
              ListTile(
                iconColor: AppColors.secondaryColor,
                splashColor: AppColors.accentColor,
                leading: const Icon(Icons.feedback),
                title: const Text('Feedback'),
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.FEEDBACK);
                },
              ),
              ListTile(
                iconColor: AppColors.secondaryColor,
                splashColor: AppColors.accentColor,
                leading: const Icon(Icons.info),
                title: const Text('About Us'),
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.ABOUT_US);
                },
              ),
              ListTile(
                iconColor: AppColors.secondaryColor,
                splashColor: AppColors.accentColor,
                leading: const Icon(Icons.support),
                title: const Text('Support and Donation'),
                onTap: () {
                  Navigator.of(context).pushNamed(AppRoutes.SUPPORT_DONATION);
                },
              ),
              ListTile(
                iconColor: AppColors.secondaryColor,
                splashColor: AppColors.accentColor,
                leading: profile == null
                    ? const Icon(Icons.login)
                    : const Icon(Icons.logout),
                title: profile == null
                    ? const Text('Sign in')
                    : const Text('Log out'),
                onTap: () {
                  if (profile == null) {
                    Navigator.pushNamedAndRemoveUntil(
                        context, AppRoutes.SIGN_IN, (route) => false);
                  } else {
                    showLogoutDialog(context);
                  }
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
