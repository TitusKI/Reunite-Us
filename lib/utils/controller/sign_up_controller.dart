// ignore_for_file: unused_local_variable

// import 'package:afalagi/bloc/sign_up/sign_up_bloc.dart';
// import 'package:afalagi/bloc/sign_up/sign_up_event.dart';
// import 'package:afalagi/bloc/sign_up/sign_up_state.dart';
// import 'package:afalagi/views/common/widgets/flutter_toast.dart';
import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:regexpattern/regexpattern.dart';

class SignUpController {
  // final BuildContext context;
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  // SignUpController(this.context);

  String? handleEmailSignUp(String fieldName, String value) {
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
      case 'repassword':
        if (value.isEmpty) {
          return "Your password confirmation is wrong";
        }
        if (value == passwordController.text) {
          return "The Password doesn't match the previous password";
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

  void handleProfileBuild() async {
    //   final state = context.read<SignUpBloc>().state;

    //   String firstName = state.firstName;
    //   String middleName = state.middleName;
    //   String lastName = state.lastName;

    //   PhoneNumber? phoneNumber = state.phoneNumber;
    //   // String? phoneNumber = state.phoneNumber;
    //   String dateOfBirth = state.dateOfBirth;
    //   if (state is GenderSelectionState) {
    //     String? gender = state.selectedGender;
    //     if (gender.isEmpty) {
    //       "gender cannot be empty";
    //     }
    //   }

    //   if (firstName.isEmpty) {
    //     "first name can not be empty";
    //   }
    //   if (middleName.isEmpty) {
    //     "middle name can not be empty";
    //   }
    //   if (lastName.isEmpty) {
    //     "last name can not be empty";
    //   }
    //   // if (location.isEmpty) {
    //   //   toastInfo(msg: "location can not be empty");
    //   //   return;
    //   // }
    //   if (phoneNumber.toString().isEmpty) {
    //     "phone number can not be empty";
    //     return;
    //   }
    //   if (dateOfBirth.isEmpty) {
    //     "date of birth can not be empty";
    //   }
    //   try {
    //     toastInfo(msg: "Profile Created Succesfully");
    //     Navigator.of(context)
    //         .pushNamedAndRemoveUntil('/sign_in', (Route<dynamic> route) => false);
    //     return;
    //   } catch (e) {
    //     print(e.toString());
    //   }
  }
}
