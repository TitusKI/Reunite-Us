// ignore: must_be_immutable
import 'dart:io';

import 'package:afalagi/utils/controller/enums.dart';
import 'package:dio/dio.dart';
import 'package:image_picker/image_picker.dart';

enum MissignImagePickState {
  initialy,
  picked,
  failed,
}

class ReportFormState {
  int page;
  final String firstName;
  final String middleName;
  final String lastName;
  final String location;

  final XFile? legalDocuments;
  final XFile? postImages;

  final MissignImagePickState? imagePickState;
  final String? errorImage;
  final String country;
  final String state;
  final String city;
  final int? age;
  final String lastSeenDate;
  final String nationality;

  final double? height;
  final HairColor? hairColor;
  final SkinColor? skinColor;
  final Gender? gender;
  final String? recognizableFeature;
  final String clothingDescription;
  final String description;
  final EducationalLevel? educationalLevel;
  final MaritalStatus? maritalStatus;
  final PosterRelation? posterRelation;

  final String videoLink;
  final bool? hasPhysicalDisability;
  final bool? hasMentalDisability;

  final String selected;
  final String dateOfBirth;
  final String dateOfDisappearance;

  final List<MentalDisability> selectedMentalDisability;
  final List<PhysicalDisability> selectedPhysicalDisability;
  final List<MedicalIssues> selectedMedicalIssues;

  final String? otherPhysicalDisability;
  final String? otherMentalDisability;
  final String? otherMedicalIssues;

  final String? languageSpoken;

  final bool? isMissingLoading;
  final bool? isMissingSuccess;
  final String? missingFailure;

  ReportFormState({
    this.posterRelation,
    this.postImages,
    this.imagePickState,
    this.errorImage,
    this.legalDocuments,
    this.languageSpoken,
    this.page = 0,
    this.lastSeenDate = '',
    this.nationality = '',
    this.selectedPhysicalDisability = const [],
    this.selectedMentalDisability = const [],
    this.selectedMedicalIssues = const [],
    this.clothingDescription = "",
    this.otherPhysicalDisability = "",
    this.otherMentalDisability = "",
    this.otherMedicalIssues = "",
    this.height,
    this.hairColor,
    this.skinColor,
    this.gender,
    this.recognizableFeature = "",
    this.description = "",
    this.educationalLevel,
    this.maritalStatus,
    this.videoLink = "",
    this.hasMentalDisability,
    this.hasPhysicalDisability,
    this.age,
    this.dateOfBirth = '',
    this.dateOfDisappearance = "",
    this.country = "",
    this.state = "",
    this.city = "",
    this.selected = "",
    this.firstName = "",
    this.middleName = "",
    this.lastName = "",
    this.location = "",
    this.isMissingLoading = false,
    this.isMissingSuccess = false,
    this.missingFailure = "",
  });

  ReportFormState.initial()
      : posterRelation = null,
        postImages = null,
        imagePickState = null,
        errorImage = null,
        legalDocuments = null,
        languageSpoken = null,
        page = 0,
        lastSeenDate = '',
        nationality = '',
        selectedPhysicalDisability = const [],
        selectedMentalDisability = const [],
        selectedMedicalIssues = const [],
        clothingDescription = "",
        otherPhysicalDisability = "",
        otherMentalDisability = "",
        otherMedicalIssues = "",
        height = null,
        hairColor = null,
        skinColor = null,
        gender = null,
        recognizableFeature = "",
        description = "",
        educationalLevel = null,
        maritalStatus = null,
        videoLink = "",
        hasMentalDisability = null,
        hasPhysicalDisability = null,
        age = null,
        dateOfBirth = '',
        dateOfDisappearance = "",
        country = "",
        state = "",
        city = "",
        selected = "",
        firstName = "",
        middleName = "",
        lastName = "",
        location = "",
        isMissingLoading = false,
        isMissingSuccess = false,
        missingFailure = "";
  factory ReportFormState.initialyy() {
    return ReportFormState(
      imagePickState: MissignImagePickState.initialy,
    );
    // phoneNumber: PhoneNumber(isoCode: "ET"));
  }
  factory ReportFormState.picked(XFile image) {
    return ReportFormState(
        imagePickState: MissignImagePickState.picked, postImages: image);
  }
  factory ReportFormState.failed(String error) {
    return ReportFormState(
        imagePickState: MissignImagePickState.failed, errorImage: error);
  }
  ReportFormState copyWith(
      {List<PhysicalDisability>? selectedPhysicalDisability,
      List<MentalDisability>? selectedMentalDisability,
      List<MedicalIssues>? selectedMedicalIssues,
      String? otherPhysicalDisability,
      String? otherMentalDisability,
      String? otherMedicalIssues,
      String? clothingDescription,
      int? age,
      double? height,
      HairColor? hairColor,
      SkinColor? skinColor,
      PosterRelation? posterRelation,
      Gender? gender,
      String? recognizableFeature,
      String? description,
      EducationalLevel? educationalLevel,
      MaritalStatus? maritalStatus,
      String? videoLink,
      bool? hasPhysicalDisability,
      bool? hasMentalDisability,
      String? firstName,
      String? middleName,
      String? lastName,
      String? location,
      String? dateOfBirth,
      String? dateOfDisappearance,
      MissignImagePickState? imagePickState,
      String? errorImage,
      XFile? postImages,
      XFile? legalDocuments,
      String? country,
      String? state,
      String? city,
      String? selected,
      int? page,
      bool? isMissingLoading,
      bool? isMissingSuccess,
      String? missingFailure}) {
    return ReportFormState(
      posterRelation: posterRelation ?? this.posterRelation,
      isMissingLoading: isMissingLoading ?? isMissingLoading,
      isMissingSuccess: isMissingSuccess ?? isMissingSuccess,
      missingFailure: missingFailure ?? missingFailure,
      lastSeenDate: lastSeenDate,
      nationality: nationality,
      otherPhysicalDisability:
          otherPhysicalDisability ?? this.otherPhysicalDisability,
      otherMentalDisability:
          otherMentalDisability ?? this.otherMentalDisability,
      otherMedicalIssues: otherMedicalIssues ?? this.otherMedicalIssues,
      selectedPhysicalDisability:
          selectedPhysicalDisability ?? this.selectedPhysicalDisability,
      selectedMentalDisability:
          selectedMentalDisability ?? this.selectedMentalDisability,
      selectedMedicalIssues:
          selectedMedicalIssues ?? this.selectedMedicalIssues,
      clothingDescription: clothingDescription ?? this.clothingDescription,
      height: height ?? this.height,
      hairColor: hairColor ?? this.hairColor,
      skinColor: skinColor ?? this.skinColor,
      gender: gender ?? this.gender,
      recognizableFeature: recognizableFeature ?? this.recognizableFeature,
      description: description ?? this.description,
      educationalLevel: educationalLevel ?? this.educationalLevel,
      maritalStatus: maritalStatus ?? this.maritalStatus,
      videoLink: videoLink ?? this.videoLink,
      hasMentalDisability: hasMentalDisability ?? this.hasMentalDisability,
      hasPhysicalDisability:
          hasPhysicalDisability ?? this.hasPhysicalDisability,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      location: location ?? this.location,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      dateOfDisappearance: dateOfDisappearance ?? this.dateOfDisappearance,
      postImages: postImages ?? this.postImages,
      legalDocuments: legalDocuments ?? this.legalDocuments,
      imagePickState: imagePickState ?? this.imagePickState,
      errorImage: errorImage ?? this.errorImage,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      selected: selected ?? this.selected,
      age: age ?? this.age,
      page: page ?? this.page,
    );
  }
}
