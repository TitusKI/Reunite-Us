import 'package:afalagi/features/auth/presentation/bloc/language/language_bloc.dart';
import 'package:afalagi/core/constants/presentation_export.dart';
import 'package:afalagi/config/theme/colors.dart';
import 'package:afalagi/features/auth/presentation/views/widgets/common_widgets.dart';
import 'package:afalagi/features/user/presentation/views/drawer_screen/screens/settings/notification_and_sound_screen/notification_and_sound.dart';
import 'package:afalagi/features/user/presentation/views/drawer_screen/widgets/language_dialog.dart';

class Setting extends StatelessWidget {
  const Setting({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarLarge("Settings"),
      body: ListView(
        children: [
          ListTile(
            iconColor: AppColors.secondaryColor,
            splashColor: AppColors.accentColor,
            leading: const Icon(Icons.person),
            title: const Text('My Account'),
            onTap: () {
              Navigator.of(context).pushNamed(AppRoutes.PROFILE);
            },
          ),
          ListTile(
            iconColor: AppColors.secondaryColor,
            splashColor: AppColors.accentColor,
            leading: const Icon(Icons.notifications),
            title: const Text('Notification and Sound'),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const NotificationAndSound()),
              );
            },
          ),
          BlocBuilder<LanguageBloc, LanguageState>(
            builder: (context, state) {
              return ListTile(
                iconColor: AppColors.secondaryColor,
                splashColor: AppColors.accentColor,
                leading: const Icon(Icons.language),
                title: const Text('Language'),
                onTap: () {
                  showLanguageDialog(context);
                },
              );
            },
          ),
          ListTile(
            iconColor: AppColors.secondaryColor,
            splashColor: AppColors.accentColor,
            leading: const Icon(Icons.storage),
            title: const Text('Storage'),
            onTap: () {
              // Navigator.push(
              //   context,
              //   MaterialPageRoute(builder: (context) => StoragePage()),
              // );
            },
          ),
        ],
      ),
    );
  }
}
