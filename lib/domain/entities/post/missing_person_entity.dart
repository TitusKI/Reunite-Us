import 'package:afalagi/data/models/Comment/comment_model.dart';
import 'package:afalagi/domain/entities/post/post_user.dart';

class MissingPersonEntity {
  // final List<File> files;
  final String? id;
  final String firstName;
  final String middleName;
  final String lastName;
  final String description;
  final String lastSeenLocation;
  final String lastSeenDate;
  final String? lastSeenWearing;
  final double? height;
  //
  final String languageSpoken;
  //
  final String nationality;
  final String? hairColor;
  final String? skinColor;
  final String? recognizableFeatures;
  //
  final String maritalStatus;
  final String posterRelation;
  final List<String> physicalDisability;
  final String? otherPhysicalDisability;
  final List<String> mentalDisability;
  final String? otherMentalDisability;
  final List<String> medicalIssues;
  final String? otherMedicalIssue;
  //
  final String gender;

  final String educationalLevel;
//
  final List<String> postImages;
  //
  final List<String> legalDocs;
  //
  final String? videoMessage;
  final String? dateOfBirth;
  final UserEntity? user;
  final List<Comment>? comment;
  final int? count;

  MissingPersonEntity({
    this.count,
    this.comment,
    this.user,
    this.id,
    required this.maritalStatus,
    required this.posterRelation,
    this.lastSeenWearing,
    this.height,
    required this.postImages,
    required this.legalDocs,
    this.videoMessage,
    required this.dateOfBirth,
    // required this.files,
    required this.firstName,
    required this.middleName,
    required this.lastName,
    required this.description,
    required this.lastSeenLocation,
    required this.lastSeenDate,
    required this.languageSpoken,
    required this.nationality,
    required this.hairColor,
    required this.skinColor,
    required this.recognizableFeatures,
    required this.physicalDisability,
    required this.otherPhysicalDisability,
    required this.mentalDisability,
    required this.otherMentalDisability,
    required this.medicalIssues,
    required this.otherMedicalIssue,
    required this.gender,
    required this.educationalLevel,
  });
}
