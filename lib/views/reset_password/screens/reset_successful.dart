import 'package:afalagi/bloc/reset_password/reset_password_bloc.dart';
import 'package:afalagi/bloc/shared_event.dart';
import 'package:afalagi/views/common/widgets/common_widgets.dart';
import 'package:afalagi/views/sign_up_screen/widgets/sign_up_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetSuccessful extends StatefulWidget {
  const ResetSuccessful({super.key});

  @override
  State<ResetSuccessful> createState() => _ResetSuccessfulState();
}

class _ResetSuccessfulState extends State<ResetSuccessful> {
  final TextEditingController newPasswordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarLarge("Reset Your Password"),
      body: SingleChildScrollView(
        child: BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
          builder: (context, state) {
            return Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    padding:
                        EdgeInsets.only(left: 25.w, right: 25.w, top: 60.h),
                    margin: EdgeInsets.only(top: 50.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                            child:
                                reusableText("Please enter your new password")),
                        const SizedBox(
                          height: 10,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        reusableText("New Password"),
                        formField(
                          fieldName: "password",
                          formType: "reset",
                          func: (value) {
                            context
                                .read<ResetPasswordBloc>()
                                .add(PasswordEvent(password: value));
                            print("password: $value");
                          },
                          value: state.password,
                          controller: newPasswordController,
                          textType: "password",
                          inputType: TextInputType.visiblePassword,
                          hintText: "Enter your new password",
                          prefixIcon: const Icon(Icons.lock),
                          context: context,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        reusableText("Confirm Password"),
                        formField(
                          fieldName: "repassword",
                          formType: "reset",
                          func: (value) {
                            context
                                .read<ResetPasswordBloc>()
                                .add(PasswordEvent(repassword: value));
                          },
                          value: state.repassword,
                          controller: confirmPasswordController,
                          textType: "password",
                          inputType: TextInputType.visiblePassword,
                          hintText: "Reenter your new password",
                          prefixIcon: const Icon(Icons.lock),
                          context: context,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 15,
                  ),

                  buildLogInAndRegButton("Proceed", true, () {
                    if (_formKey.currentState!.validate()) {
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          "/sign_in", (Route<dynamic> routes) => false);
                    }
                    // ResetPasswordController(context).handlePasswordReset();
                    // SignInController(context: context).handleSignIn("email");
                  }),

                  // buildLogInAndRegButton("Sign Up", "register", () {
                  //   Navigator.of(context).pushNamed("/sign_up");
                  // })
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
