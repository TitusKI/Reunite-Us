import 'package:afalagi/core/constants/constant.dart';
import 'package:afalagi/data/models/Auth/user_profile_model.dart';
import 'package:afalagi/core/constants/presentation_export.dart';
import 'package:afalagi/config/theme/colors.dart';
import 'package:afalagi/presentation/views/common/drawer_screen/widgets/show_dialog.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDrawer extends StatefulWidget {
  const AppDrawer({super.key});

  @override
  State<AppDrawer> createState() => _AppDrawerState();
}

class _AppDrawerState extends State<AppDrawer> {
  @override
  void initState() {
    super.initState();
    context.read<ProfileCubit>().fetchProfile();
  }

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final isDarkMode = themeCubit.state.brightness == Brightness.dark;
    // context.read<ProfileCubit>().fetchProfile();
    return BlocBuilder<ProfileCubit, GenericState>(
      builder: (context, state) {
        if (state.isLoading) {
          return const Center(child: CircularProgressIndicator());
        }

        // if (state.failure != null) {
        //   return Center(child: Text('Error: ${state.failure}'));
        // }

        final profile = state.data as UserProfile?;
        print("Display on the Drawer");
        print(profile);
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
                  profile?.firstName ?? 'Welcome Guest',
                  style: const TextStyle(
                    color: AppColors.primaryBackground,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                accountEmail: Text(
                  profile?.email ?? 'guest@gmail.com',
                  style: const TextStyle(
                    color: AppColors.primaryBackground,
                  ),
                ),
                currentAccountPicture: GestureDetector(
                  onTap: () {
                    Navigator.of(context).pushNamed(AppRoutes.PROFILE);
                  },
                  child: CircleAvatar(
                    backgroundColor: AppColors.primaryBackground,
                    backgroundImage: profile?.profilePicture != null
                        ? NetworkImage(profilePictureUrl)
                        : const AssetImage('assets/icons/user.png')
                            as ImageProvider,
                  ),
                ),
              ),
              ListTile(
                iconColor: AppColors.secondaryColor,
                splashColor: AppColors.accentColor,
                style: ListTileStyle.list,
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
                leading: const Icon(Icons.logout),
                title: const Text('Log out'),
                onTap: () {
                  showLogoutDialog(context);
                },
              ),
              SizedBox(
                height: 250.h,
              ),
              const Divider(),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    const Text(
                      'Dark Mode',
                    ),
                    Switch(
                        value: isDarkMode,
                        onChanged: (bool value) {
                          themeCubit.toggleTheme();
                        }),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
