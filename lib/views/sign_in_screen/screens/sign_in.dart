import 'package:afalagi/bloc/shared_event.dart';
import 'package:afalagi/bloc/sign_in/sign_in_bloc.dart';
import 'package:afalagi/routes/routes.dart';

import 'package:afalagi/global.dart';

import 'package:afalagi/utils/controller/sign_in_controller.dart';
import 'package:afalagi/views/common/values/colors.dart';
import 'package:afalagi/views/common/values/constant.dart';
import 'package:afalagi/views/common/widgets/common_widgets.dart';
import 'package:afalagi/views/sign_up_screen/widgets/sign_up_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();
  SignInController _signInController = SignInController();
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:
          AppColors.accentColor, // Set status bar color for home screen
      statusBarIconBrightness: Brightness.light, // Light text/icons
    ));
    return BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.primaryBackground,
          appBar: buildAppBarLarge("Log In"),
          body: SingleChildScrollView(
            child: Form(
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
                        reusableText("Email"),
                        SizedBox(
                          height: 5.h,
                        ),
                        formField(
                          fieldName: "email",
                          value: state.email,
                          controller: _signInController.emailController,
                          textType: "email",
                          hintText: "Enter your email address",
                          prefixIcon: const Icon(Icons.email),
                          inputType: TextInputType.emailAddress,
                          func: (value) {
                            context.read<SignInBloc>().add(EmailEvent(value));
                          },
                          formType: 'sign in',
                          context: context,
                        ),
                        SizedBox(
                          height: 5.h,
                        ),
                        reusableText("Password"),
                        formField(
                          fieldName: "password",
                          value: state.password,
                          controller: _signInController.passwordController,
                          textType: "password",
                          hintText: "Enter your password",
                          prefixIcon: const Icon(Icons.lock),
                          inputType: TextInputType.visiblePassword,
                          func: (value) {
                            context
                                .read<SignInBloc>()
                                .add(PasswordEvent(password: value));
                          },
                          formType: 'sign in',
                          context: context,
                        ),
                        Row(
                          children: [
                            IconButton(
                                onPressed: () {},
                                icon:
                                    const Icon(Icons.check_box_outline_blank)),
                            const Text(
                              "Remember Password",
                              style: TextStyle(color: AppColors.primaryText),
                            ),
                            const SizedBox(
                              width: 35,
                            ),
                            forgotPassword(() {
                              Navigator.of(context)
                                  .pushNamed("/reset_password");
                            }),
                          ],
                        )
                      ],
                    ),
                  ),

                  buildLogInAndRegButton("Log In", true, () {
                    if (_formKey.currentState!.validate()) {
                      Global.storageService
                          .setBool(AppConstant.STORAGE_USER_TOKEN_KEY, true);
                      // Navigator.of(context).pushNamedAndRemoveUntil(
                      //     AppRoutes.MAIN, (Route<dynamic> route) => false);
                      // Navigator.of(context).pushNamed(AppRoutes.Main);
                      // Navigator.of(context).pushNamed('/home');
                      Navigator.of(context).pushNamedAndRemoveUntil(
                          AppRoutes.MAIN, (Route<dynamic> route) => false);
                    }
                  }),
                  const SizedBox(
                    height: 5.0,
                  ),
                  Center(
                    child: reusableText("Or use your google account to login"),
                  ),
                  buildThirdPartyLogin(context),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        "Don't have an account?",
                        style: TextStyle(color: AppColors.primaryText),
                      ),
                      const SizedBox(
                        width: 35,
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pushNamed("/sign_up");
                        },
                        child: const Text(
                          "sign up",
                          style: TextStyle(color: AppColors.accentColor),
                        ),
                      )
                    ],
                  )
                  // buildLogInAndRegButton("Sign Up", "register", () {
                  //   Navigator.of(context).pushNamed("/sign_up");
                  // })
                ],
              ),
            ),
          ),
        ),
      );
    });
  }
}
