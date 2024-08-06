import 'package:afalagi/data/models/user/user_profile_model.dart';
import 'package:afalagi/domain/entities/post/post_user.dart';

class User {
  final String id;
  final String email;
  final UserProfile profile;

  User({
    required this.id,
    required this.email,
    required this.profile,
  });
  factory User.fromJson(Map<String, dynamic> json) => User(
        id: json['id'] as String,
        email: json['email'] as String,
        profile: UserProfile.fromJson(json['Profile']),
      );
  UserEntity toEntity() {
    return UserEntity(id: id, email: email, profile: profile);
  }
}
