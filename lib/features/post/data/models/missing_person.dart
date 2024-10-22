import 'package:afalagi/features/user/data/models/user_model.dart';
import 'package:afalagi/features/comment/data/models/comment_model.dart';
import 'package:afalagi/features/post/domain/entities/missing_person_entity.dart';

class MissingPerson {
  // final List<File> files;
  final String? id;
  final String? userId;
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
  final User? user;
  final List<Comment>? comments;
  final int? count;

  MissingPerson({
    this.count,
    this.userId,
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
    this.user,
    this.comments,
  });
// convert from Entity (Convert Entity To Model)
  factory MissingPerson.fromEntity(MissingPersonEntity entity) {
    return MissingPerson(
      maritalStatus: entity.maritalStatus.toString(),
      posterRelation: entity.posterRelation.toString(),
      postImages: entity.postImages,
      legalDocs: entity.legalDocs,
      dateOfBirth: entity.dateOfBirth,
      firstName: entity.firstName,
      middleName: entity.middleName,
      lastName: entity.lastName,
      description: entity.description,
      lastSeenLocation: entity.lastSeenLocation,
      lastSeenDate: entity.lastSeenDate,
      languageSpoken: entity.languageSpoken,
      nationality: entity.nationality,
      hairColor: entity.hairColor.toString(),
      skinColor: entity.skinColor.toString(),
      recognizableFeatures: entity.recognizableFeatures,
      physicalDisability: entity.physicalDisability,
      otherPhysicalDisability: entity.otherPhysicalDisability,
      mentalDisability: entity.mentalDisability,
      otherMentalDisability: entity.otherMentalDisability,
      medicalIssues: entity.medicalIssues,
      otherMedicalIssue: entity.otherMedicalIssue,
      gender: entity.gender.toString(),
      educationalLevel: entity.educationalLevel.toString(),
    );
  }
// Convert to Json (Send to the API)
  Map<String, dynamic> toJson() {
    return {
      // 'files': files
      //     .map((file) => MultipartFile.fromFileSync(file.path,
      //         filename: file.path.split('/').last))
      //     .toList(),
      'firstName': firstName,
      'middleName': middleName,
      'lastName': lastName,
      'description': description,
      'lastSeenLocation': lastSeenLocation,
      'lastSeenWearing': lastSeenWearing,
      'lastSeenDate': lastSeenDate,
      'height': height,
      //
      'languageSpoken': languageSpoken,
      //
      'nationality': nationality,
      'hairColor': hairColor,
      'skinColor': skinColor,
      'recognizableFeatures': recognizableFeatures,
      'physicalDisability': physicalDisability,
      'otherPhysicalDisability': otherPhysicalDisability!.toUpperCase(),
      'mentalDisability': mentalDisability,
      'otherMentalDisability': otherMentalDisability,

      'medicalIssues': medicalIssues,
      'otherMedicalIssue': otherMedicalIssue,
      'gender': gender,
      'dateOfBirth': dateOfBirth,
      'educationalLevel': educationalLevel,
// //
//       'postImages': postImages,
//       //
//       'legalDocs': legalDocs,
//       //
//       'videoMessage': videoMessage,
    };
  }

// convert from Json (API Response to Model)
  factory MissingPerson.fromJson(Map<String, dynamic> json) {
    return MissingPerson(
      firstName: json['firstName'],
      middleName: json['middleName'],
      lastName: json['lastName'],
      description: json['description'],
      lastSeenLocation: json['lastSeenLocation'],
      lastSeenWearing: json['lastSeenWearing'],
      lastSeenDate: DateTime.parse(json['lastSeenDate']).toString(),
      height: json['height']?.toDouble(),
      languageSpoken: json['languageSpoken'],
      nationality: json['nationality'],
      hairColor: json['hairColor'],
      skinColor: json['skinColor'],
      recognizableFeatures: json['recognizableFeatures'],
      physicalDisability: List<String>.from(json['physicalDisability']),
      otherPhysicalDisability: json['otherPhysicalDisability'],
      mentalDisability: List<String>.from(json['mentalDisability']),
      otherMentalDisability: json['otherMentalDisability'],
      medicalIssues: List<String>.from(json['medicalIssues']),
      otherMedicalIssue: json['otherMedicalIssue'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      educationalLevel: json['educationalLevel'],
      postImages: List<String>.from(json['images']),
      legalDocs: List<String>.from(json['legalDocuments']),
      videoMessage: json['videoMessage'],
      maritalStatus: json['maritalStatus'],
      posterRelation: json['posterRelation'],
      id: json['id'],
      userId: json['userId'],
      user: User.fromJson(json['user']),
      comments: (json['comments'] as List)
          .map((json) => Comment.fromJson(json))
          .toList(),
      count: json['_count']['comments'],
    );
  }
  // Convert to Domain Entity
  MissingPersonEntity toEntity() {
    return MissingPersonEntity(
        maritalStatus: maritalStatus,
        posterRelation: posterRelation,
        postImages: postImages,
        legalDocs: legalDocs,
        dateOfBirth: dateOfBirth,
        firstName: firstName,
        middleName: middleName,
        lastName: lastName,
        description: description,
        lastSeenLocation: lastSeenLocation,
        lastSeenDate: lastSeenDate,
        languageSpoken: languageSpoken,
        nationality: nationality,
        hairColor: hairColor,
        skinColor: skinColor,
        recognizableFeatures: recognizableFeatures,
        physicalDisability: physicalDisability,
        otherPhysicalDisability: otherPhysicalDisability,
        mentalDisability: mentalDisability,
        otherMentalDisability: otherMentalDisability,
        medicalIssues: medicalIssues,
        otherMedicalIssue: otherMedicalIssue,
        gender: gender,
        educationalLevel: educationalLevel,
        id: id,
        user: user!.toEntity(),
        comment: comments as List<Comment>);
  }
}

// class PostResponse {
//   final int page;
//   final int pageSize;
//   final int totalPages;
//   final int totalRecords;
//   final List<MissingPerson> data;

//   PostResponse({
//     required this.page,
//     required this.pageSize,
//     required this.totalPages,
//     required this.totalRecords,
//     required this.data,
//   });

//   factory PostResponse.fromJson(Map<String, dynamic> json) {
//     return PostResponse(
//       page: json['page'],
//       pageSize: json['pageSize'],
//       totalPages: json['totalPages'],
//       totalRecords: json['totalRecords'],
//       data: List<MissingPerson>.from(
//         json['data'].map((postJson) => MissingPerson.fromJson(postJson)),
//       ),
//     );
//   }
// }
