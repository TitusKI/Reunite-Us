import 'package:afalagi/bloc/sign_up/sign_up_bloc.dart';
import 'package:afalagi/bloc/sign_up/sign_up_event.dart';
import 'package:afalagi/utils/controller/reset_password_controller.dart';

import 'package:afalagi/views/common/widgets/common_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetSuccessful extends StatefulWidget {
  const ResetSuccessful({super.key});

  @override
  State<ResetSuccessful> createState() => _ResetSuccessfulState();
}

class _ResetSuccessfulState extends State<ResetSuccessful> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarLarge("Reset Your Password"),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              padding: EdgeInsets.only(left: 25.w, right: 25.w, top: 60.h),
              margin: EdgeInsets.only(top: 50.h),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(child: reusableText("Please enter your new password")),
                  const SizedBox(
                    height: 10,
                  ),
                  SizedBox(
                    height: 5.h,
                  ),
                  reusableText("New Password"),
                  buildTextField("Enter new password", "password", "lock",
                      (value) {
                    context.read<SignUpBloc>().add(PasswordEvent(value));
                  }),
                  reusableText("Confirm Password"),
                  buildTextField(
                      "Re-enter password to confirm", "confirmpassword", "lock",
                      (value) {
                    context.read<SignUpBloc>().add(RepasswordEvent(value));
                  }),
                ],
              ),
            ),
            const SizedBox(
              height: 15,
            ),

            buildLogInAndRegButton("Proceed", true, () {
              ResetPasswordController(context).handlePasswordReset();
              // SignInController(context: context).handleSignIn("email");
            }),

            // buildLogInAndRegButton("Sign Up", "register", () {
            //   Navigator.of(context).pushNamed("/sign_up");
            // })
          ],
        ),
      ),
    );
  }
}
