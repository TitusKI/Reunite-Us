import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/features/user/domain/repository/user_repository.dart';
import 'package:afalagi/injection_container.dart';

class DeleteProfilePicUsecase implements Usecase<void, void> {
  @override
  Future<void> call({void parms}) {
    return sl<UserRepository>().deleteProfilePicture();
  }
}
