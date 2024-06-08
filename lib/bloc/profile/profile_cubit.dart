import 'package:afalagi/bloc/generic_state.dart';
import 'package:afalagi/model/user_profile_model.dart';
import 'package:afalagi/repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';

class ProfileCubit extends Cubit<GenericState> {
  final UserRepository _repository;

  ProfileCubit(this._repository) : super(const GenericState());

  Future<void> fetchProfile() async {
    print("Fetching started...");
    emit(state.copyWith(isLoading: true));
    try {
      final UserProfile profile = await _repository.fetchUserProfile();
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

  Future<void> updateProfilePicture(FormData formData) async {
    emit(state.copyWith(isLoading: true, failure: null));
    try {
      final UserProfile profile =
          await _repository.updateProfilePicture(formData);
      emit(state.copyWith(isLoading: false, data: profile));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, failure: 'Failed to update profile picture: $e'));
    }
  }

  Future<void> updateUserProfile(Map<String, dynamic> updates) async {
    emit(state.copyWith(isLoading: true, failure: null));
    try {
      final UserProfile profile = await _repository.updateUserProfile(updates);
      emit(state.copyWith(isLoading: false, data: profile));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, failure: 'Failed to update profile: $e'));
    }
  }
}
