import 'package:afalagi/bloc/sign_up/sign_up_bloc.dart';
import 'package:afalagi/utils/controller/sign_up_controller.dart';
import 'package:afalagi/views/common/values/colors.dart';
import 'package:afalagi/views/common/widgets/common_widgets.dart';
import 'package:afalagi/views/sign_up_screen/widgets/sign_up_widgets.dart';
import 'package:flutter/material.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  SignUpController _signUpController = SignUpController();
  String formType = "sign up";

  final _formKey = GlobalKey<FormState>();
  late SignUpBloc _signUpBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);
  }

  @override
  void dispose() {
    _signUpBloc.add(SignUpReset());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpStates>(
      builder: (context, state) {
        return Form(
          key: _formKey,
          child: Container(
            color: AppColors.primaryBackground,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: AppColors.primaryBackground,
                appBar: buildAppBarLarge("Sign Up"),
                body: SingleChildScrollView(
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
                            reusableText("Email"),
                            formField(
                                fieldName: "email",
                                value: state.email,
                                controller: _signUpController.emailController,
                                textType: "email",
                                hintText: "Enter your email address",
                                prefixIcon: const Icon(Icons.email),
                                inputType: TextInputType.emailAddress,
                                func: (value) {
                                  context
                                      .read<SignUpBloc>()
                                      .add(EmailEvent(value));
                                },
                                formType: formType,
                                context: context),
                            SizedBox(
                              height: 20.h,
                            ),
                            reusableText("Password"),
                            formField(
                              formType: formType,
                              fieldName: "password",
                              value: state.password,
                              controller: _signUpController.passwordController,
                              textType: "password",
                              hintText: "Enter your password",
                              prefixIcon: const Icon(Icons.lock),
                              inputType: TextInputType.visiblePassword,
                              func: (value) {
                                context
                                    .read<SignUpBloc>()
                                    .add(PasswordEvent(value));
                              },
                              context: context,
                            ),
                            SizedBox(
                              height: 20.h,
                            ),
                            reusableText("Confirm Password"),
                            formField(
                              formType: formType,
                              fieldName: "repassword",
                              value: state.repassword,
                              controller:
                                  _signUpController.confirmPasswordController,
                              textType: "password",
                              hintText: "Re-enter your password to confirm",
                              prefixIcon: const Icon(Icons.lock),
                              inputType: TextInputType.visiblePassword,
                              func: (value) {
                                context
                                    .read<SignUpBloc>()
                                    .add(RepasswordEvent(value));
                              },
                              context: context,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20.h,
                      ),
                      Container(
                        margin: EdgeInsets.only(left: 25.w),
                        child: reusableText(
                            "By creating an account you have agree with our terms and conditions"),
                      ),
                      // if (state.isSignUpLoading)
                      //   const CircularProgressIndicator(),
                      buildLogInAndRegButton("Sign Up", true, () {
                        if (_formKey.currentState!.validate()) {
                          // context
                          //     .read<SignUpBloc>()
                          //     .add(SignUpLoadingEvent());
                          // await Future.delayed(const Duration(seconds: 2));
                          Navigator.of(context)
                              .pushNamed("/sign_up_verification");
                        }
                        // Navigator.of(context).pushNamed("SignUp");
                        // SignUpController(context).handleEmailSignUp();
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
