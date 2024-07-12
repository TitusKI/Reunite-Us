part of 'report_form_bloc.dart';

// ignore: must_be_immutable
class ReportFormState {
  int page;

  final String firstName;
  final String middleName;
  final String lastName;
  final String location;

  final String password;
  final String repassword;

  final File? profileImage;
  final ImagePickState? imagePickState;
  final String? errorImage;
  final String country;
  final String state;
  final String city;
  final int? age;

  final double? height;
  final String hairColor;
  final String skinColor;
  final String recongnizableFeature;
  final String clothingDescription;
  final String description;
  final String educationalLevel;
  final String videoLink;
  final bool? hasPhysicalDisability;
  final bool? hasMentalDisability;

  final String selected;
  final String dateOfBirth;
  final String dateOfDisapperance;

  final List<String?> selectedMentalDisability;
  final List<String?> selectedPhysicalDisability;

  final String otherPhysicalDisability;
  final String otherMentalDisability;

  ReportFormState({
    this.selectedPhysicalDisability = const [],
    this.selectedMentalDisability = const [],
    this.clothingDescription = "",
    this.otherPhysicalDisability = "",
    this.otherMentalDisability = "",
    this.height,
    this.hairColor = "",
    this.skinColor = "",
    this.recongnizableFeature = "",
    this.description = "",
    this.educationalLevel = "",
    this.videoLink = "",
    this.hasMentalDisability,
    this.hasPhysicalDisability,
    this.age,
    this.page = 0,
    this.firstName = "",
    this.middleName = "",
    this.lastName = "",
    this.location = "",
    this.password = "",
    this.repassword = "",
    this.dateOfBirth = '',
    this.dateOfDisapperance = "",
    this.profileImage,
    this.imagePickState,
    this.errorImage,
    this.country = "",
    this.state = "",
    this.city = "",
    this.selected = "",
  });
  ReportFormState copyWith({
    List<String?>? selectedPhysicalDisability,
    List<String?>? selectedMentalDisability,
    String? otherPhysicalDisability,
    String? otherMentalDisability,
    String? clothingDescription,
    int? age,
    double? height,
    String? hairColor,
    String? skinColor,
    String? recongnizableFeature,
    String? description,
    String? educationalLevel,
    String? videoLink,
    bool? hasPhysicalDisability,
    bool? hasMentalDisability,
    String? firstName,
    String? middleName,
    String? lastName,
    String? location,
    String? password,
    String? repassword,
    String? dateOfBirth,
    String? dateOfDisapperance,
    File? profileImage,
    ImagePickState? imagePickState,
    String? errorImage,
    String? country,
    String? state,
    String? city,
    bool? obscurePassword,
    String? selected,
    int? page,
  }) {
    return ReportFormState(
      otherPhysicalDisability:
          otherPhysicalDisability ?? this.otherPhysicalDisability,
      otherMentalDisability:
          otherMentalDisability ?? this.otherMentalDisability,
      selectedPhysicalDisability:
          selectedPhysicalDisability ?? this.selectedPhysicalDisability,
      selectedMentalDisability:
          selectedMentalDisability ?? this.selectedMentalDisability,
      clothingDescription: clothingDescription ?? this.clothingDescription,
      page: page ?? this.page,
      height: height ?? this.height,
      hairColor: hairColor ?? this.hairColor,
      skinColor: skinColor ?? this.skinColor,
      recongnizableFeature: recongnizableFeature ?? this.recongnizableFeature,
      description: description ?? this.description,
      educationalLevel: educationalLevel ?? this.educationalLevel,
      videoLink: videoLink ?? this.videoLink,
      hasMentalDisability: hasMentalDisability ?? this.hasMentalDisability,
      hasPhysicalDisability:
          hasPhysicalDisability ?? this.hasPhysicalDisability,
      firstName: firstName ?? this.firstName,
      middleName: middleName ?? this.middleName,
      lastName: lastName ?? this.lastName,
      location: location ?? this.location,
      password: password ?? this.password,
      repassword: repassword ?? this.repassword,
      dateOfBirth: dateOfBirth ?? this.dateOfBirth,
      dateOfDisapperance: dateOfDisapperance ?? this.dateOfDisapperance,
      profileImage: profileImage ?? this.profileImage,
      imagePickState: imagePickState ?? this.imagePickState,
      errorImage: errorImage ?? this.errorImage,
      country: country ?? this.country,
      state: state ?? this.state,
      city: city ?? this.city,
      selected: selected ?? this.selected,
      age: age ?? this.age,
    );
  }
}
