import 'package:afalagi/bloc/reset_password/reset_password_bloc.dart';
import 'package:afalagi/bloc/sign_up/sign_up_bloc.dart';
import 'package:afalagi/views/common/widgets/flutter_toast.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:regexpattern/regexpattern.dart';

class ResetPasswordController {
  BuildContext context;
  ResetPasswordController(this.context);

  void handleEmailReset() async {
    try {
      final state = context.read<ResetPasswordBloc>().state;
      String? email = state.email;
      print("The email state is: $email");

      if (email.isEmpty) {
        toastInfo(msg: "Email cannot be empty");
        return;
      } else if (!email.isEmail()) {
        toastInfo(msg: "The email format is invalid. Please enter a valid one");
        return;
      } else {
        try {
          toastInfo(msg: "Reset Password Sent Api integration");

          Navigator.of(context).pushNamed('/reset_verification');
        } catch (e) {
          print(e.toString());
        }
      }
    } catch (e) {
      print(e.toString());
    }
  }

  void handlePasswordReset() {
    final state = context.read<SignUpBloc>().state;
    String? password = state.password;
    String? repassword = state.repassword;
    try {
      if (password.isEmpty) {
        toastInfo(msg: "Password can not be empty");
        return;
      }
      if (password.length < 8) {
        toastInfo(msg: "Password must be at least 8 character long");
        return;
      }

      if (repassword.isEmpty) {
        toastInfo(msg: "Your password confirmation is wrong");
        return;
      }
      if (repassword != password) {
        toastInfo(msg: "The Password doesn't match the previous password");
        return;
      } else {
        toastInfo(
            msg: "Reset Password Succesful!", gravity: ToastGravity.CENTER);
        Navigator.of(context).pushNamedAndRemoveUntil(
            '/sign_in', (Route<dynamic> route) => false);
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
