// ignore: unused_import
import 'package:afalagi/core/constants/presentation_export.dart';
import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/features/auth/domain/entities/signin_user_req.dart';
import 'package:afalagi/features/auth/domain/repository/auth_repository.dart';
import 'package:afalagi/injection_container.dart';

class SignInUseCase extends Usecase<void, SigninUserReq> {
// do this dependency injection or use get_it service Locator
  // final AuthRepository _authRepository;
  // SignInUseCase(this._authRepository);

  @override
  Future<void> call({SigninUserReq? parms}) {
    return sl<AuthRepository>().signin(parms!);
  }
}
