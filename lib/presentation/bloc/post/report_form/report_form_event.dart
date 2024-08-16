// Ensure this imports your enums

import 'package:afalagi/domain/entities/post/missing_person_entity.dart';
import 'package:afalagi/presentation/bloc/shared_event.dart';
import 'package:afalagi/core/util/controller/enums.dart';

class ReportFormEvent extends SharedEvent {
  final int? onAge;
  final double? onHeight;
  final HairColor? onHairColor;
  final SkinColor? onSkinColor;
  final Gender? onGender;
  final String? onRecognizableFeature;
  final String? onDescription;
  final EducationalLevel? onEducationalLevel;
  final MaritalStatus? onMaritalStatus;
  final String? onVideoLink;
  final String? onClothingDescription;
  final String? onLanguageSpoken;

  final String? onNationality;

  final String selected;

  final PhysicalDisability? physicalDisability;
  final String? otherPhysicalDisability;
  final MentalDisability? mentalDisability;
  final String? otherMentalDisability;
  final MedicalIssues? medicalIssues;
  final String? otherMedicalIssues;

  const ReportFormEvent({
    this.onLanguageSpoken,
    this.onNationality,
    this.onGender,
    this.physicalDisability,
    this.otherPhysicalDisability,
    this.mentalDisability,
    this.otherMentalDisability,
    this.medicalIssues,
    this.otherMedicalIssues,
    this.selected = "",
    this.onHeight,
    this.onAge,
    this.onHairColor,
    this.onSkinColor,
    this.onRecognizableFeature,
    this.onClothingDescription,
    this.onDescription,
    this.onEducationalLevel,
    this.onMaritalStatus,
    this.onVideoLink,
  });

  @override
  List<Object> get props => [
        if (physicalDisability != null) physicalDisability!,
        if (otherPhysicalDisability != null) otherPhysicalDisability!,
        if (mentalDisability != null) mentalDisability!,
        if (otherMentalDisability != null) otherMentalDisability!,
        if (medicalIssues != null) medicalIssues!,
        if (otherMedicalIssues != null) otherMedicalIssues!,
        selected,
        if (onAge != null) onAge!,
        if (onHeight != null) onHeight!,
        if (onHairColor != null) onHairColor!,
        if (onSkinColor != null) onSkinColor!,
        if (onRecognizableFeature != null) onRecognizableFeature!,
        if (onClothingDescription != null) onClothingDescription!,
        if (onDescription != null) onDescription!,
        if (onEducationalLevel != null) onEducationalLevel!,
        if (onVideoLink != null) onVideoLink!,
      ];
}

class MissingPersonPost extends ReportFormEvent {
  final MissingPersonEntity missingPerson;
  // final XFile postImages;
  // final XFile legalDocs;
  // final List<MultipartFile?>? videoMessage;
  const MissingPersonPost({
    required this.missingPerson,
    // required this.postImages,
    // required this.legalDocs,
    // this.videoMessage,
  });
}

class MissingReset extends ReportFormEvent {}
