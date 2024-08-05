import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/data/models/Auth/user_profile_model.dart';
import 'package:afalagi/domain/repository/user/user_repository.dart';
import 'package:afalagi/injection_container.dart';

class UpdateUserProfileUsecase
    implements Usecase<UserProfile, Map<String, dynamic>> {
  @override
  Future<UserProfile> call({Map<String, dynamic>? parms}) {
    return sl<UserRepository>().updateUserProfile(parms!);
  }
}
