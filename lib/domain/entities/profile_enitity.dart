import 'dart:io';

import 'package:afalagi/data/models/Auth/user_profile_model.dart';

class ProfileEnitity {
  final UserProfile userProfile;
  final File file;

  ProfileEnitity({required this.userProfile, required this.file});
}
