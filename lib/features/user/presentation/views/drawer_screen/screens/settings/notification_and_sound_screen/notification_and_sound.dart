import 'package:afalagi/config/theme/colors.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../../../../core/constants/presentation_export.dart';

class NotificationAndSound extends StatefulWidget {
  const NotificationAndSound({super.key});

  @override
  _NotificationAndSoundState createState() => _NotificationAndSoundState();
}

class _NotificationAndSoundState extends State<NotificationAndSound> {
  bool _notificationsEnabled = true;
  bool _soundEnabled = true;
  double _volume = 50.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarLarge("Notification and Sounds"),
      body: Padding(
        padding: EdgeInsets.all(16.w),
        child: ListView(
          children: [
            Text(
              'Notification Settings',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            SwitchListTile(
              activeColor: AppColors.accentColor,
              title: Text('Enable Notifications',
                  style: TextStyle(fontSize: 16.sp)),
              value: _notificationsEnabled,
              onChanged: (bool value) {
                setState(() {
                  _notificationsEnabled = value;
                });
              },
            ),
            SwitchListTile(
              activeColor: AppColors.accentColor,
              title: Text('Enable Sound', style: TextStyle(fontSize: 16.sp)),
              value: _soundEnabled,
              onChanged: (bool value) {
                setState(() {
                  _soundEnabled = value;
                });
              },
            ),
            ListTile(
              title: Text('Volume', style: TextStyle(fontSize: 16.sp)),
              trailing: SizedBox(
                width: 150.w,
                child: Slider(
                  activeColor: AppColors.accentColor,
                  value: _volume,
                  min: 0,
                  max: 100,
                  divisions: 100,
                  label: _volume.round().toString(),
                  onChanged: (double value) {
                    setState(() {
                      _volume = value;
                    });
                  },
                ),
              ),
            ),
            SizedBox(height: 20.h),
            Text(
              'Sound Options',
              style: TextStyle(fontSize: 18.sp, fontWeight: FontWeight.bold),
            ),
            ListTile(
              title:
                  Text('Notification Sound', style: TextStyle(fontSize: 16.sp)),
              trailing: Icon(Icons.arrow_forward_ios, size: 16.sp),
              onTap: () {
                // Navigate to sound selection screen
              },
            ),
          ],
        ),
      ),
    );
  }
}
