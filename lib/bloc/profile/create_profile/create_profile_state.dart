import 'dart:io';

import 'package:afalagi/utils/controller/enums.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

enum ImagePickState {
  initialy,
  picked,
  failed,
}

class CreateProfileState {
  final String firstName;
  final String middleName;
  final String lastName;
  final String fullName;
  final String location;

  final bool? isValid;
  final PhoneNumber? phoneNumber;

  final File? profileImage;
  final ImagePickState? imagePickState;
  final String? errorImage;
  final String country;
  final String state;
  final String city;

  final bool isProfileLoading;
  final bool isProfileSuccess;
  final String? profileFailure;
  final Gender? selected;
  final String dateOfBirth;

  const CreateProfileState({
    this.isValid,
    this.firstName = "",
    this.middleName = "",
    this.lastName = "",
    this.fullName = "",
    this.location = "",
    this.dateOfBirth = '',
    this.profileImage,
    this.imagePickState,
    this.errorImage,
    this.phoneNumber,
    this.country = "",
    this.state = "",
    this.city = "",
    this.isProfileLoading = false,
    this.isProfileSuccess = false,
    this.profileFailure = "",
    this.selected,
  });
  CreateProfileState.initial()
      : firstName = "",
        middleName = "",
        lastName = "",
        fullName = "",
        location = "",
        phoneNumber = PhoneNumber(isoCode: "ET"),
        isValid = false,
        imagePickState = ImagePickState.initialy,
        profileImage = null,
        errorImage = "retry",
        dateOfBirth = "",
        country = "",
        state = "",
        city = "",
        selected = Gender.Male,
        isProfileSuccess = false,
        profileFailure = null,
        isProfileLoading = false;

  factory CreateProfileState.initialyy() {
    return const CreateProfileState(
      imagePickState: ImagePickState.initialy,
    );
    // phoneNumber: PhoneNumber(isoCode: "ET"));
  }
  factory CreateProfileState.picked(File image) {
    return CreateProfileState(
        imagePickState: ImagePickState.picked, profileImage: image);
  }
  factory CreateProfileState.failed(String error) {
    return CreateProfileState(
        imagePickState: ImagePickState.failed, errorImage: error);
  }
  CreateProfileState copyWith({
    String? firstName,
    String? middleName,
    String? lastName,
    String? fullName,
    String? location,
    PhoneNumber? phoneNumber,
    bool? isValid,
    String? dateOfBirth,
    File? profileImage,
    ImagePickState? imagePickState,
    String? errorImage,
    String? country,
    String? state,
    String? city,
    bool? isProfileLoading,
    bool? isProfileSuccess,
    String? profileFailure,
    Gender? selected,
  }) {
    return CreateProfileState(
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      fullName: fullName ?? this.fullName,
      location: location ?? this.location,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      profileImage: profileImage ?? this.profileImage,
      imagePickState: imagePickState ?? this.imagePickState,
      errorImage: errorImage ?? this.errorImage,
      isValid: isValid ?? this.isValid,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      isProfileLoading: isProfileLoading ?? this.isProfileLoading,
      isProfileSuccess: isProfileSuccess ?? this.isProfileSuccess,
      profileFailure: profileFailure ?? this.profileFailure,
      selected: selected ?? this.selected,
    );
  }
}

// CreateProfileState createProfileState = const CreateProfileState();
// //image picked state
// final createProfile = createProfileState.copyWith(
//   imagePickState: ImagePickState.picked,
// );
