import 'package:afalagi/bloc/sign_up/sign_up_bloc.dart';
import 'package:afalagi/bloc/sign_up/sign_up_event.dart';
import 'package:afalagi/views/common/widgets/flutter_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regexpattern/regexpattern.dart';

class SignUpController {
  final BuildContext context;
  const SignUpController(this.context);

  void handleEmailSignUp() async {
    final state = context.read<SignUpBloc>().state;
    String userName = state.userName;
    String email = state.email;
    String password = state.password;
    String repassword = state.repassword;

    if (userName.isEmpty) {
      toastInfo(msg: "User name can not be empty");
      return;
    }
    if (email.isEmpty) {
      toastInfo(msg: "Email can not be empty");
      return;
    }
    if (!email.isEmail()) {
      toastInfo(msg: "Please Enter a Valid Email Address");
    }
    if (password.isEmpty) {
      toastInfo(msg: "Password can not be empty");
      return;
    }

    if (repassword.isEmpty) {
      toastInfo(msg: "Your password confirmation is wrong");
      return;
    }
    if (repassword != password) {
      toastInfo(msg: "The Password doesn't match the previous password");
      return;
    }

    try {
      context.read<SignUpBloc>().add(SignUpLoadingEvent());
      print("Registe user Api integration");
    } catch (e) {
      context.read<SignUpBloc>().add(SignUpFailureEvent(error: e.toString()));
    }
  }
}
