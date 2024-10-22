import 'package:afalagi/features/user/data/models/user_profile_model.dart';

class UserEntity {
  final String id;
  final String email;
  final UserProfile profile;

  UserEntity({
    required this.id,
    required this.email,
    required this.profile,
  });
}
