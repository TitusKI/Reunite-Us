// lib/validators/user_validator.dart

import 'package:afalagi/model/user_model.dart';
import 'package:regexpattern/regexpattern.dart';

class UserValidator {
  final User user;

  UserValidator(this.user);

  String? validate() {
    if (user.email!.isEmpty) {
      return "Email can't be empty";
    }
    if (!user.email!.isEmail()) {
      return "Please Enter a Valid Email Address";
    }

    if (user.password!.isEmpty) {
      return "Password can't be empty";
    }

    if (user.confirmPassword!.isEmpty) {
      return "Your password confirmation is wrong";
    }
    if (user.confirmPassword != user.password) {
      return "The passwords do not match";
    }

    return null;
  }
}
