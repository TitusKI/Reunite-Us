import 'package:afalagi/bloc/sign_up/sign_up_bloc.dart';
import 'package:afalagi/bloc/sign_up/sign_up_event.dart';
import 'package:afalagi/bloc/sign_up/sign_up_state.dart';
import 'package:afalagi/utils/controller/sign_up_controller.dart';
import 'package:afalagi/views/common/values/colors.dart';
import 'package:afalagi/views/common/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpStates>(
      builder: (context, state) {
        return Container(
          color: AppColors.primaryBackground,
          child: SafeArea(
            child: Scaffold(
              backgroundColor: AppColors.primaryBackground,
              appBar: buildAppBarLarge("Sign Up"),
              body: SingleChildScrollView(
                child: Container(
                  // decoration: const BoxDecoration(
                  //     gradient: LinearGradient(
                  //   colors: [
                  //     AppColors.secondaryColor,
                  //     AppColors.primaryBackground,
                  //     AppColors.primaryBackground,
                  //     AppColors.primaryBackground
                  //   ],
                  //   begin: Alignment.topCenter,
                  //   end: Alignment.bottomCenter,
                  // )),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                          child: reusableText(
                              "Enter your details below and free sign Up")),
                      Container(
                        padding: EdgeInsets.only(left: 25.w, right: 25.w),
                        margin: EdgeInsets.only(top: 50.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            reusableText("User name"),
                            buildTextField(
                                "Enter your user name", "name", "user",
                                (value) {
                              context
                                  .read<SignUpBloc>()
                                  .add(UserNameEvent(value));
                            }),
                            reusableText("Email"),
                            buildTextField(
                                "Enter your email address", "email", "user",
                                (value) {
                              context.read<SignUpBloc>().add(EmailEvent(value));
                            }),
                            reusableText("Password"),
                            buildTextField(
                                "Enter your password", "password", "lock",
                                (value) {
                              context
                                  .read<SignUpBloc>()
                                  .add(PasswordEvent(value));
                            }),
                            reusableText("Confirm Password"),
                            buildTextField("Re-enter your password to confirm",
                                "confirmpassword", "lock", (value) {
                              context
                                  .read<SignUpBloc>()
                                  .add(RepasswordEvent(value));
                            }),
                          ],
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25.w),
                        child: reusableText(
                            "By creating an account you have agree with our terms and conditions"),
                      ),
                      buildLogInAndRegButton("Sign Up", true, () {
                        // Navigator.of(context).pushNamed("SignUp");
                        SignUpController(context).handleEmailSignUp();
                      })
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
