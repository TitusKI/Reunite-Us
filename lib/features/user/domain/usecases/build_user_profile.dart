import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/features/user/domain/repository/user_repository.dart';
import 'package:afalagi/injection_container.dart';

import '../entities/user_profile_entity.dart';

class BuildUserProfileUsecase implements Usecase<void, UserProfileEntity> {
  @override
  Future<void> call({UserProfileEntity? parms}) {
    return sl<UserRepository>().buildUserProfile(parms!);
  }
}
