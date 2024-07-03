import 'package:flutter/material.dart';

import 'package:regexpattern/regexpattern.dart';

class SignInController {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  String? handleSignIn(String fieldName, String value) {
    switch (fieldName) {
      case 'email':
        if (value.isEmpty) {
          return "Email can't be empty";
        }
        if (!value.isEmail()) {
          return "Please Enter a Valid Email Address";
        }
        break;
      case 'password':
        if (value.isEmpty) {
          return "Password can't be empty ";
        }
        break;

      default:
        return null;
    }
    {
      // try {
      //   context.read<SignUpBloc>().add(SignUpLoadingEvent());
      //   toastInfo(msg: "Registe user Api integration");
      //   Navigator.of(context).pushNamed('/sign_up_verification');
      // } catch (e) {
      //   context.read<SignUpBloc>().add(SignUpFailureEvent(error: e.toString()));
      // }
    }
    return null;
  }
}
