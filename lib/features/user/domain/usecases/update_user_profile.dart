import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/features/user/data/models/user_profile_model.dart';
import 'package:afalagi/features/user/domain/repository/user_repository.dart';
import 'package:afalagi/injection_container.dart';

class UpdateUserProfileUsecase
    implements Usecase<UserProfile, Map<String, dynamic>> {
  @override
  Future<UserProfile> call({Map<String, dynamic>? parms}) {
    return sl<UserRepository>().updateUserProfile(parms!);
  }
}
