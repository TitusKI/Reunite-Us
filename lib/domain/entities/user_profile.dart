class UserProfileEntity {
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
  final String? email;

  UserProfileEntity({
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
    this.email,
  });
}
