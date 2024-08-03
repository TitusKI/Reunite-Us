// ignore: unused_import
import 'package:afalagi/core/constants/presentation_export.dart';
import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/domain/entities/auth/user_entity.dart';
import 'package:afalagi/domain/repository/auth/auth_repository.dart';
import 'package:afalagi/injection_container.dart';

class SignUpUsecase extends Usecase<void, User> {
  // final AuthRepository _authRepository;
  // SignUpUsecase(this._authRepository);

  @override
  Future<void> call({User? parms}) {
    return sl<AuthRepository>().signUp(parms!);
  }
}
