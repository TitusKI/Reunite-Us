import 'package:afalagi/features/auth/domain/entities/email_verify_req.dart';
import 'package:afalagi/features/auth/domain/entities/signin_user_req.dart';
import 'package:afalagi/features/auth/domain/entities/user_entity.dart';

abstract class AuthRepository {
  Future<void> signUp(User user);
  Future<void> signin(SigninUserReq user);
  Future<void> signInWithGoogle();
  Future<void> forgotPassword(String email);
  Future<void> resetPassword(String newPassword, String passwordConfirm);
  Future<void> signOut();
  Future<void> verifyCode(EmailVerifyReq emailVerify);
  Future<String> refreshToken();
  Future<void> resendCode(String email);
}
