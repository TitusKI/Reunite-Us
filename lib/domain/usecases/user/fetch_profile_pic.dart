import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/domain/repository/user/user_repository.dart';
import 'package:afalagi/injection_container.dart';
import 'package:dio/dio.dart';

class FetchProfilePicUsecase implements Usecase<Response, void> {
  @override
  Future<Response> call({void parms}) {
    return sl<UserRepository>().fetchProfilePicture();
  }
}
