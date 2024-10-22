import 'dart:io';

import 'package:afalagi/features/user/data/models/user_profile_model.dart';
import 'package:afalagi/features/user/data/services/user_services.dart';
import 'package:afalagi/features/user/domain/repository/user_repository.dart';
import 'package:dio/dio.dart';

class UserRepositoryImpl extends UserRepository {
  final UserServices _apiServices;
  UserRepositoryImpl(this._apiServices);

  @override
  Future<void> buildUserProfile(UserProfile userProfile, File file) async {
    await _apiServices.buildUserProfile(userProfile: userProfile, file: file);
  }

  @override
  Future<UserProfile> fetchUserProfile() async {
    return _apiServices.getMyProfile();
  }

  @override
  Future<UserProfile> updateUserProfile(Map<String, dynamic> updates) async {
    return _apiServices.updateUserProfile(updates);
  }

  @override
  Future<Response> fetchProfilePicture() async {
    return _apiServices.getProfilePicture();
  }

  @override
  Future<void> deleteProfilePicture() async {
    return await _apiServices.deleteProfilePicture();
  }

  @override
  Future<File?> updateProfilePicture(FormData formData) async {
    return await _apiServices.updateProfilePicture(formData);
  }
}
