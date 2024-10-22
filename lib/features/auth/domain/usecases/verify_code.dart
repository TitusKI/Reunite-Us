import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/features/auth/domain/entities/email_verify_req.dart';
import 'package:afalagi/features/auth/domain/repository/auth_repository.dart';
import 'package:afalagi/injection_container.dart';

class VerifyCodeUsecase extends Usecase<void, EmailVerifyReq> {
  // final AuthRepository _authRepository;
  // VerifyCodeUsecase(this._authRepository);

  @override
  Future<void> call({EmailVerifyReq? parms}) {
    return sl<AuthRepository>().verifyCode(parms!);
  }
}
