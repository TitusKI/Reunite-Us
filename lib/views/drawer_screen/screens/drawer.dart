import 'package:afalagi/bloc/theme_cubit/theme_cubit.dart';
import 'package:afalagi/routes/export.dart';
import 'package:afalagi/views/common/values/colors.dart';
import 'package:afalagi/views/drawer_screen/widgets/show_dialog.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.read<ThemeCubit>();
    final isDarkMode = themeCubit.state.brightness == Brightness.dark;
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            decoration: const BoxDecoration(
              color: AppColors.secondaryColor,
              image: DecorationImage(
                opacity: 0.5,
                image: AssetImage(
                  'assets/logo/logo.png',
                ),
                fit: BoxFit.cover,
              ),
            ),
            accountName: const Text('Welcome Guest',
                style: TextStyle(
                  color: AppColors.primaryBackground,
                  fontWeight: FontWeight.bold,
                )),
            accountEmail: const Text('guest@gmail.com',
                style: TextStyle(
                  color: AppColors.primaryBackground,
                )),
            currentAccountPicture: GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(AppRoutes.PROFILE);
              },
              child: const CircleAvatar(
                backgroundColor: AppColors.primaryBackground,
                backgroundImage: AssetImage('assets/icons/user.png'),
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
  }
}
