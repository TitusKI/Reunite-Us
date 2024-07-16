import 'package:afalagi/services/api_services.dart';

class UserRepository {
  final ApiServices _apiServices;
  UserRepository(this._apiServices);
  Future<void> signUp(
      {required String email,
      required String password,
      required String passwordConfirm}) async {
    print("repo email is:: $email");
    await _apiServices.signup(email, password, passwordConfirm);
  }

  Future<void> verifyCode({
    required String email,
    required String code,
  }) async {
    print("repo email is:: $email");
    await _apiServices.verifyCode(email, code);
  }
}
