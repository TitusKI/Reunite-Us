import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/domain/entities/profile_enitity.dart';
import 'package:afalagi/domain/repository/user/user_repository.dart';
import 'package:afalagi/injection_container.dart';

class BuildUserProfileUsecase implements Usecase<void, ProfileEnitity> {
  @override
  Future<void> call({ProfileEnitity? parms}) {
    return sl<UserRepository>()
        .buildUserProfile(parms!.userProfile, parms.file);
  }
}
