import 'package:afalagi/utils/controller/sign_in_controller.dart';
import 'package:afalagi/utils/controller/sign_up_controller.dart';
import 'package:afalagi/views/common/widgets/build_textfield.dart';
import 'package:flutter/material.dart';

Widget formField({
  required String formType,
  String? fieldName,
  String? value,
  TextEditingController? controller,
  String? textType,
  String? hintText,
  Icon? prefixIcon,
  IconButton? suffixIcon,
  TextInputType? inputType,
  void Function(String value)? func,
  final bool? obscureText = true,
}) {
  return MyTextField(
    prefixIcon: prefixIcon,
    controller: controller!,
    validator: formType == "sign in"
        ? (validate) => SignInController().handleSignIn(fieldName!, value!)
        : (validate) =>
            SignUpController().handleEmailSignUp(fieldName!, value!),
    hintText: hintText!,
    obscureText: fieldName == "password" ? obscureText! : false,
    suffixIcon: suffixIcon,
    keyboardType: inputType!,
    onChanged: (value) => func!(value),
  );
}
