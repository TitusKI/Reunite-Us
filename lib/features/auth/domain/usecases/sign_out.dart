import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/features/auth/domain/repository/auth_repository.dart';
import 'package:afalagi/injection_container.dart';

class SignOutUsecase extends Usecase<void, void> {
  // final AuthRepository _authRepository;
  // SignOutUsecase(this._authRepository);

  @override
  Future<void> call({void parms}) {
    return sl<AuthRepository>().signOut();
  }
}
