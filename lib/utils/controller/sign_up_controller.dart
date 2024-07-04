import 'package:afalagi/bloc/sign_up/sign_up_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:regexpattern/regexpattern.dart';

class SignUpController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController middleNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();

  String? handleEmailSignUp(
      BuildContext context, String fieldName, String value) {
    final SignUpStates state = context.read<SignUpBloc>().state;
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
        if (value != state.password) {
          return "The passwords do not match";
        }
        break;

      default:
        return null;
    }

    return null;
  }

  String? validateLocation(BuildContext context) {
    final state = context.read<SignUpBloc>().state;

    if (state.country.isEmpty) {
      return "Country is required";
    }
    if (state.state.isEmpty) {
      return "State is required";
    }
    if (state.city.isEmpty) {
      return "City is required";
    }
    return null;
  }

  String? validatePhoneNumber(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number cannot be empty';
    }

    if (!value.isPhone()) {
      return 'please Enter a valid phone number';
    }
    return null;
  }

  String? handleProfileBuild(
      BuildContext context, String fieldName, String value) {
    // ignore: unused_local_variable
    final SignUpStates state = context.read<SignUpBloc>().state;

    // String firstName = state.firstName;
    // String middleName = state.middleName;
    // String lastName = state.lastName;
    switch (fieldName) {
      case 'firstName':
        if (value.isEmpty) {
          return "First name can not be empty";
        }
        if (!value.isAlphabet()) {
          return "Name can not be number";
        }
        break;
      case 'middleName':
        if (value.isEmpty) {
          return "Middle name can not be empty";
        }
        if (!value.isAlphabet()) {
          return " Name can not be number";
        }
        break;
      case 'lastName':
        if (value.isEmpty) {
          return "Last name can not be empty";
        }
        if (!value.isAlphabet()) {
          return " Name can not be number";
        }
        break;

      default:
        return null;
    }

    return null;
  }
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
