// lib/data/models/user_profile_model.dart

import 'dart:io';
import 'package:dio/dio.dart';
import 'package:json_annotation/json_annotation.dart';
import '../../domain/entities/user_profile_entity.dart';

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
  final String? email;
  // File for uploading profile picture

  UserProfile({
    this.email,
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

  // JSON serialization and deserialization
  factory UserProfile.fromJson(Map<String, dynamic> json) =>
      _$UserProfileFromJson(json);

  Map<String, dynamic> toJson() => _$UserProfileToJson(this);

  // Convert Model to Entity
  UserProfileEntity toEntity() {
    return UserProfileEntity(
      firstName: firstName ?? '',
      lastName: lastName ?? '',
      birthDate: birthDate ?? '',
      country: country ?? '',
      gender: gender ?? '',
      middleName: middleName,
      phoneNumber: phoneNumber,
      state: state,
      city: city,
      profilePicture: profilePicture,
      // email: email,
    );
  }

  // Create Model from Entity
  factory UserProfile.fromEntity(
    UserProfileEntity entity,
  ) {
    return UserProfile(
      firstName: entity.firstName,
      lastName: entity.lastName,
      birthDate: entity.birthDate,
      country: entity.country,
      gender: entity.gender,
      middleName: entity.middleName,
      phoneNumber: entity.phoneNumber,
      state: entity.state,
      city: entity.city,
      profilePicture: entity.profilePicture,
    );
  }

  // Convert Model to FormData for API requests
  FormData toFormData() {
    final data = <String, dynamic>{
      'firstName': firstName,
      'phoneNumber': phoneNumber,
      'middleName': middleName,
      'lastName': lastName,
      'gender': gender,
      'country': country,
      'birthDate': birthDate,
    };

    // Check if the file path for `profilePicture` is valid and exists
    if (profilePicture != null && File(profilePicture!).existsSync()) {
      data['profilePicture'] = MultipartFile.fromFileSync(profilePicture!,
          filename: profilePicture!.split('/').last,
          contentType: DioMediaType('image', 'png'));
    } else {
      print("Error: Profile picture file does not exist or path is invalid.");
    }

    return FormData.fromMap(data);
  }
}
