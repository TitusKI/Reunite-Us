import 'dart:io';

import 'package:afalagi/core/usecase/usecase.dart';
import 'package:afalagi/domain/repository/user/user_repository.dart';
import 'package:afalagi/injection_container.dart';
import 'package:dio/dio.dart';

class UpdateProfilePicUsecase implements Usecase<File?, FormData> {
  @override
  Future<File?> call({FormData? parms}) {
    return sl<UserRepository>().updateProfilePicture(parms!);
  }
}
