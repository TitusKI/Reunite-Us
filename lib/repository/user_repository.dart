import 'dart:io';

import 'package:afalagi/model/missing_person.dart';
import 'package:afalagi/model/user_model.dart';
import 'package:afalagi/model/user_profile_model.dart';
import 'package:afalagi/services/api_services.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class UserRepository {
  final ApiServices _apiServices;
  UserRepository(this._apiServices);
  Future<void> signUp(User user) async {
    print("repo email is:: ${user.email}");
    await _apiServices.signup(user);
  }

  Future<void> signin(String email, String password) async {
    print("repo signin email is : $email");
    await _apiServices.signin(email, password);
  }

  Future<void> signInWithGoogle() async {
    await _apiServices.signinGoogle();
    await _apiServices.handleGoogleRedirect();
  }

  Future<void> forgotPassword(String email) async {
    print("repo forgot email is : $email");
    await _apiServices.forgotPassword(email);
  }

  Future<void> resetPassword(String newPassword, String passwordConfirm) async {
    print("repo reset to $newPassword");
    await _apiServices.resetPassword(newPassword, passwordConfirm);
  }

  Future<void> signOut() async {
    await _apiServices.signOut();
  }

  Future<void> verifyCode({
    required String email,
    required int code,
  }) async {
    print("repo email is:: $email");
    await _apiServices.verifyCode(email, code);
  }

  Future<String> refreshToken() {
    return _apiServices.refreshToken();
  }

  Future<void> resendCode(String email) async {
    await _apiServices.resendCode(email);
  }

  Future<void> buildUserProfile(UserProfile userProfile, File file) async {
    await _apiServices.buildUserProfile(userProfile: userProfile, file: file);
  }

  Future<UserProfile> fetchUserProfile() async {
    return _apiServices.getMyProfile();
  }

  Future<UserProfile> updateUserProfile(Map<String, dynamic> updates) async {
    return _apiServices.updateUserProfile(updates);
  }

  Future<Response> fetchProfilePicture(String token) async {
    return _apiServices.getProfilePicture(token);
  }

  Future<void> deleteProfilePicture() async {
    return await _apiServices.deleteProfilePicture();
  }

  Future<UserProfile> updateProfilePicture(FormData formData) async {
    return await _apiServices.updateProfilePicture(formData);
  }

  Future<MissingPerson> createPost(
      {required MissingPerson missingPerson,
      required XFile postImages,
      required XFile legalDocs,
      List<MultipartFile?>? videoMessage}) async {
    return await _apiServices.createPost(
        missingPerson, postImages, legalDocs, videoMessage);
  }

  Future<PostResponse> getMyPosts() async {
    return await _apiServices.getMyPosts();
  }

  Future<PostResponse> getAllPosts() async {
    return await _apiServices.getAllPosts();
  }
}
