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

    String email = state.email;
    String password = state.password;
    String repassword = state.repassword;

    if (email.isEmpty) {
      toastInfo(msg: "Email can not be empty");
      return;
    } else if (!email.isEmail()) {
      toastInfo(msg: "Please Enter a Valid Email Address");
    } else if (password.isEmpty) {
      toastInfo(msg: "Password can not be empty");
      return;
    } else if (repassword.isEmpty) {
      toastInfo(msg: "Your password confirmation is wrong");
      return;
    } else if (repassword != password) {
      toastInfo(msg: "The Password doesn't match the previous password");
      return;
    } else {
      try {
        context.read<SignUpBloc>().add(SignUpLoadingEvent());
        toastInfo(msg: "Registe user Api integration");
        Navigator.of(context).pushNamed('/sign_up_verification');
      } catch (e) {
        context.read<SignUpBloc>().add(SignUpFailureEvent(error: e.toString()));
      }
    }
  }

  void handleProfileBuild() async {
    final state = context.read<SignUpBloc>().state;
    String firstName = state.firstName;
    String middleName = state.middleName;
    String lastName = state.lastName;
    String location = state.location;
    String? phoneNumber = state.phoneNumber;
    String? dateOfBirth = state.dateOfBirth;
    if (firstName.isEmpty) {
      toastInfo(msg: "first name can not be empty");
      return;
    } else if (middleName.isEmpty) {
      toastInfo(msg: "middle name can not be empty");
      return;
    } else if (lastName.isEmpty) {
      toastInfo(msg: "last name can not be empty");
      return;
    } else if (location.isEmpty) {
      toastInfo(msg: "location can not be empty");
      return;
    } else if (phoneNumber.toString().isEmpty) {
      toastInfo(msg: "phone number can not be empty");
      return;
    } else if (dateOfBirth!.isEmpty) {
      toastInfo(msg: "date of birth can not be empty");
      return;
    } else {
      toastInfo(msg: "Profile Created Succesfully");
      Navigator.of(context)
          .pushNamedAndRemoveUntil('/sign_in', (Route<dynamic> route) => false);
      return;
    }
  }
}
