import 'dart:io';

import 'package:afalagi/features/user/data/models/user_profile_model.dart';

class ProfileEnitity {
  final UserProfile userProfile;
  final File file;

  ProfileEnitity({required this.userProfile, required this.file});
}
