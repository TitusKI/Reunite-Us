import 'package:afalagi/bloc/sign_in/sign_in_bloc.dart';
import 'package:afalagi/views/common/widgets/flutter_toast.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:regexpattern/regexpattern.dart';

class SignInController {
  final BuildContext context;
  SignInController({required this.context});

  void handleSignIn(String type) async {
    try {
      if (type == "email") {
        // Read and access Sign In Bloc here to get the state
        final state = context.read<SignInBloc>().state;
        String emailAddress = state.email;
        String userPassword = state.password;
        print(emailAddress);
        if (emailAddress.isEmpty) {
          toastInfo(msg: "You need to fill email address");
          return;
        }
        if (!emailAddress.isEmail()) {
          toastInfo(msg: "Please put valid Email address");
          return;
        }
        if (userPassword.isEmpty) {
          toastInfo(msg: "You need to fill password");
          return;
        }
        try {
          print("Handle Sign In Api Integration");
          Navigator.of(context).pushNamed("/home");
        } catch (e) {
          print(e.toString());
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
