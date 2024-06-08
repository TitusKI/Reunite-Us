import 'package:afalagi/utils/controller/enums.dart';

class MissingPerson {
  // final List<File> files;
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
  final HairColor? hairColor;
  final SkinColor? skinColor;
  final String? recognizableFeatures;
  //
  final MaritalStatus maritalStatus;
  final PosterRelation posterRelation;
  final List<PhysicalDisability> physicalDisability;
  final String? otherPhysicalDisability;
  final List<MentalDisability> mentalDisability;
  final String? otherMentalDisability;
  final List<MedicalIssues> medicalIssues;
  final String? otherMedicalIssue;
  //
  final Gender gender;

  final EducationalLevel educationalLevel;
//
  // final List<String> postImages;
  // //
  // final List<String> legalDocs;
  // //
  // final String? videoMessage;
  final String? dateOfBirth;

  MissingPerson({
    required this.maritalStatus,
    required this.posterRelation,
    this.lastSeenWearing,
    this.height,
    // required this.postImages,
    // required this.legalDocs,
    // this.videoMessage,
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
      'otherPhysicalDisability': otherPhysicalDisability,
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
      physicalDisability:
          List<PhysicalDisability>.from(json['physicalDisability']),
      otherPhysicalDisability: json['otherPhysicalDisability'],
      mentalDisability: List<MentalDisability>.from(json['mentalDisability']),
      otherMentalDisability: json['otherMentalDisability'],
      medicalIssues: List<MedicalIssues>.from(json['medicalIssues']),
      otherMedicalIssue: json['otherMedicalIssue'],
      gender: json['gender'],
      dateOfBirth: json['dateOfBirth'],
      educationalLevel: json['educationalLevel'],
      // postImages: List<String>.from(json['postImages']),
      // legalDocs: List<String>.from(json['legalDocs']),
      // videoMessage: json['videoMessage'],
      maritalStatus: json['maritalStatus'],
      posterRelation: json['posterRelation'],
    );
  }
}

class PostResponse {
  final int page;
  final int pageSize;
  final int totalPages;
  final int totalRecords;
  final List<MissingPerson> data;

  PostResponse({
    required this.page,
    required this.pageSize,
    required this.totalPages,
    required this.totalRecords,
    required this.data,
  });

  factory PostResponse.fromJson(Map<String, dynamic> json) {
    return PostResponse(
      page: json['page'],
      pageSize: json['pageSize'],
      totalPages: json['totalPages'],
      totalRecords: json['totalRecords'],
      data: List<MissingPerson>.from(
        json['data'].map((postJson) => MissingPerson.fromJson(postJson)),
      ),
    );
  }
}
