import 'dart:io';

import 'package:afalagi/data/models/Auth/user_profile_model.dart';
import 'package:dio/dio.dart';

abstract class UserRepository {
  Future<void> buildUserProfile(UserProfile userProfile, File file);
  Future<UserProfile> fetchUserProfile();
  Future<UserProfile> updateUserProfile(Map<String, dynamic> updates);
  Future<Response> fetchProfilePicture();

  Future<void> deleteProfilePicture();
  Future<File?> updateProfilePicture(FormData formData);
}
