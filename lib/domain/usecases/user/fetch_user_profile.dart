import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/data/models/Auth/user_profile_model.dart';
import 'package:afalagi/domain/repository/user/user_repository.dart';
import 'package:afalagi/injection_container.dart';

class FetchUserProfileUsecase extends Usecase<UserProfile, void> {
  @override
  Future<UserProfile> call({void parms}) {
    return sl<UserRepository>().fetchUserProfile();
  }
}
