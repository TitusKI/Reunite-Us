import 'package:afalagi/utils/controller/enums.dart';

// Helper methods for HairColor
extension HairColorExtension on HairColor {
  String get value => toString().split('.').last.toUpperCase();

  static HairColor fromString(String value) {
    return HairColor.values.firstWhere(
      (e) => e.value == value.toUpperCase(),
      orElse: () => HairColor.Black, // default value
    );
  }
}

// Helper methods for SkinColor
extension SkinColorExtension on SkinColor {
  String get value => toString().split('.').last.toUpperCase();

  static SkinColor fromString(String value) {
    return SkinColor.values.firstWhere(
      (e) => e.value == value.toUpperCase(),
      orElse: () => SkinColor.White, // default value
    );
  }
}

// Helper methods for EducationalLevel
extension EducationalLevelExtension on EducationalLevel {
  String get value => toString().split('.').last.toUpperCase();

  static EducationalLevel fromString(String value) {
    return EducationalLevel.values.firstWhere(
      (e) => e.value == value.toUpperCase(),
      orElse: () => EducationalLevel.None, // default value
    );
  }
}

// Helper methods for Gender
extension GenderExtension on Gender {
  String get value => toString().split('.').last.toUpperCase();

  static Gender fromString(String value) {
    return Gender.values.firstWhere(
      (e) => e.value == value.toUpperCase(),
      orElse: () => Gender.Male, // default value
    );
  }
}

// Helper methods for PhysicalDisability
extension PhysicalDisabilityExtension on PhysicalDisability {
  String get value => toString().split('.').last.toUpperCase();

  static PhysicalDisability fromString(String value) {
    return PhysicalDisability.values.firstWhere(
      (e) => e.value == value.toUpperCase(),
      orElse: () => PhysicalDisability.MobilityIssue, // default value
    );
  }
}

// Helper methods for MentalDisability
extension MentalDisabilityExtension on MentalDisability {
  String get value => toString().split('.').last.toUpperCase();

  static MentalDisability fromString(String value) {
    return MentalDisability.values.firstWhere(
      (e) => e.value == value.toUpperCase(),
      orElse: () => MentalDisability.IntellectualDisability, // default value
    );
  }
}

// Helper methods for MedicalIssue
extension MedicalIssueExtension on MedicalIssues {
  String get value => toString().split('.').last.toUpperCase();

  static MedicalIssues fromString(String value) {
    return MedicalIssues.values.firstWhere(
      (e) => e.value == value.toUpperCase(),
      orElse: () => MedicalIssues.Hypertension, // default value
    );
  }
}
