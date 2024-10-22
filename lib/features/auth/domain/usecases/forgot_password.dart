import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/features/auth/domain/repository/auth_repository.dart';
import 'package:afalagi/injection_container.dart';

class ForgotPasswordUsecase extends Usecase<void, String> {
  // final AuthRepository _authRepository;
  // ForgotPasswordUsecase(this._authRepository);

  @override
  Future<void> call({String? parms}) {
    return sl<AuthRepository>().forgotPassword(parms!);
  }
}
