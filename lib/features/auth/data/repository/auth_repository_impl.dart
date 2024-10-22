import 'package:afalagi/features/auth/data/services/remote/auth_services.dart';
import 'package:afalagi/features/auth/domain/entities/email_verify_req.dart';
import 'package:afalagi/features/auth/domain/entities/signin_user_req.dart';
import 'package:afalagi/features/auth/domain/entities/user_entity.dart';
import 'package:afalagi/features/auth/domain/repository/auth_repository.dart';
import 'package:afalagi/injection_container.dart';

class AuthRepositoryImpl extends AuthRepository {
  // final ApiServices _authServices;
  // AuthRepositoryImpl(this._authServices);
  final AuthServices _authServices = sl<AuthServices>();
  @override
  Future<void> signUp(User user) async {
    print("repo email is:: ${user.email}");
    await _authServices.signup(user);
  }

  @override
  Future<void> signin(SigninUserReq? user) async {
    print("repo signin email is : ${user!.email}");
    await _authServices.signin(user.email, user.password);
  }

  @override
  Future<void> signInWithGoogle() async {
    await _authServices.signinGoogle();
    await _authServices.handleGoogleRedirect();
  }

  @override
  Future<void> forgotPassword(String email) async {
    print("repo forgot email is : $email");
    await _authServices.forgotPassword(email);
  }

  @override
  Future<void> resetPassword(String newPassword, String passwordConfirm) async {
    print("repo reset to $newPassword");
    await _authServices.resetPassword(newPassword, passwordConfirm);
  }

  @override
  Future<void> signOut() async {
    await _authServices.signOut();
  }

  @override
  Future<void> verifyCode(EmailVerifyReq emailVerify) async {
    print("repo email is:: $emailVerify!.email");
    await _authServices.verifyCode(emailVerify.email, emailVerify.code);
  }

  @override
  Future<String> refreshToken() {
    return _authServices.refreshToken();
  }

  @override
  Future<void> resendCode(String email) async {
    await _authServices.resendCode(email);
  }
}
