import 'package:json_annotation/json_annotation.dart';
part 'user_profile_model.g.dart';

@JsonSerializable()
class UserProfile {
  final String? firstName;
  final String? middleName;

  final String? lastName;
  final String? phoneNumber;
  final String? state;
  final String? city;
  final String? country;
  final String? birthDate;
  final String? profilePicture;
  final String? gender;

  UserProfile({
    this.phoneNumber,
    required this.firstName,
    this.middleName,
    required this.lastName,
    required this.birthDate,
    this.state,
    this.city,
    required this.country,
    required this.gender,
    this.profilePicture,
  });
  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);
  Map<String, dynamic> toJson() => _$UserProfileToJson(this);
}
