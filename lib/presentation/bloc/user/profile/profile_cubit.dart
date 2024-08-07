import 'dart:io';

import 'package:afalagi/domain/usecases/user/delete_profile_pic.dart';
import 'package:afalagi/domain/usecases/user/fetch_profile_pic.dart';
import 'package:afalagi/domain/usecases/user/fetch_user_profile.dart';
import 'package:afalagi/domain/usecases/user/update_profile_pic.dart';
import 'package:afalagi/domain/usecases/user/update_user_profile.dart';
import 'package:afalagi/injection_container.dart';
import 'package:afalagi/presentation/bloc/generic_state.dart';
import 'package:afalagi/data/models/user/user_profile_model.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

class ProfileCubit extends Cubit<GenericState> {
  // final ImagePicker _imagePicker = ImagePicker();

  ProfileCubit() : super(const GenericState());

  Future<void> fetchProfile() async {
    print("Fetching started...");
    emit(state.copyWith(isLoading: true));
    try {
      final UserProfile profile = await sl<FetchUserProfileUsecase>().call();
      print(profile.birthDate);
      print(profile.city);

      print(profile.gender);

      print(profile.country);

      print(profile.state);

      print(profile.profilePicture);
      print(profile.firstName);

      print(profile.middleName);

      print(profile.lastName);
      print(profile.toJson());

      emit(state.copyWith(isLoading: false, data: profile));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, failure: 'Failed to load profile: $e'));
    }
  }

  Future<void> pickImage() async {
    final imageFile =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (imageFile != null) {
      emit(state.copyWith(imageFile: File(imageFile.name)));
    }
  }

  Future<void> updateProfilePicture(FormData formData) async {
    emit(state.copyWith(isLoading: true, failure: null));
    try {
      final profile = await sl<UpdateProfilePicUsecase>().call(parms: formData);
      emit(state.copyWith(isLoading: false, imageFile: profile));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, failure: 'Failed to update profile picture: $e'));
    }
  }

  Future<void> deleteProfilePicture() async {
    emit(state.copyWith(isLoading: true, failure: null));
    try {
      await sl<DeleteProfilePicUsecase>().call();
      emit(state.copyWith(isLoading: false, data: null));
      final updatedProfile = state.data?.copyWith(profilePicture: null);
      emit(state.copyWith(
          isLoading: false, data: updatedProfile, imageFile: null));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, failure: 'Failed to update profile picture: $e'));
    }
  }

  Future<void> getProfilePicture() async {
    print("Fetching started...");
    emit(state.copyWith(isLoading: true));
    try {
      final profilePicture = await sl<FetchProfilePicUsecase>().call();

      emit(state.copyWith(isLoading: false, data: profilePicture));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, failure: 'Failed to load profile: $e'));
    }
  }

  Future<void> updateUserProfile(Map<String, dynamic> updates) async {
    emit(state.copyWith(isLoading: true, failure: null));
    try {
      final UserProfile profile =
          await sl<UpdateUserProfileUsecase>().call(parms: updates);
      emit(state.copyWith(isLoading: false, data: profile));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, failure: 'Failed to update profile: $e'));
    }
  }
}
