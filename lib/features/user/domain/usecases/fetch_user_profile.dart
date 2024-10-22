import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/features/user/data/models/user_profile_model.dart';
import 'package:afalagi/features/user/domain/repository/user_repository.dart';
import 'package:afalagi/injection_container.dart';

class FetchUserProfileUsecase extends Usecase<UserProfile, void> {
  @override
  Future<UserProfile> call({void parms}) {
    return sl<UserRepository>().fetchUserProfile();
  }
}
