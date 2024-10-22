import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/features/auth/domain/repository/auth_repository.dart';
import 'package:afalagi/injection_container.dart';

class RefreshTokenUsecase extends Usecase<void, void> {
  // final AuthRepository _authRepository;
  // RefreshTokenUsecase(this._authRepository);

  @override
  Future<void> call({void parms}) {
    return sl<AuthRepository>().refreshToken();
  }
}
