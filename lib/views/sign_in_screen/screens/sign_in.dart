import 'package:afalagi/bloc/shared_event.dart';
import 'package:afalagi/bloc/sign_in/sign_in_bloc.dart';

import 'package:afalagi/routes/routes.dart';

import 'package:afalagi/global.dart';

import 'package:afalagi/utils/controller/sign_in_controller.dart';
import 'package:afalagi/views/common/values/colors.dart';
import 'package:afalagi/views/common/values/constant.dart';
import 'package:afalagi/views/common/widgets/common_widgets.dart';
import 'package:afalagi/views/sign_in_screen/widgets/AnimatedText.dart';
import 'package:afalagi/views/sign_in_screen/widgets/language.dart';
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
  final SignInController _signInController = SignInController();
  late SignInBloc _signInBloc;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _signInBloc = BlocProvider.of<SignInBloc>(context);
  }

  @override
  void dispose() {
    _signInBloc.add(SignInReset());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor:
          AppColors.secondaryColor, // Set status bar color for home screen
      statusBarIconBrightness: Brightness.light, // Light text/icons
    ));
    return BlocBuilder<SignInBloc, SignInState>(builder: (context, state) {
      return SafeArea(
        child: Scaffold(
          backgroundColor: AppColors.primaryBackground,
          appBar:
              buildAppBarLarge('Log In', actions: [const LanguageDropdown()]),
          body: SingleChildScrollView(
            child: Form(
              key: _formKey,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(
                    height: 15.h,
                  ),
                  Center(
                    child: Image.asset(
                      'assets/logo/logo.png', // Your logo image path
                      width: 150.h,
                    ),
                  ),
                  Container(
                    padding:
                        EdgeInsets.only(left: 25.w, right: 25.w, top: 10.h),
                    margin: EdgeInsets.only(top: 25.h),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Center(
                        //   child: Image.asset(
                        //     'assets/logo/logo.png', // Your logo image path
                        //     height: 100.h,
                        //   ),
                        // ),
                        // SizedBox(
                        //   height: 15.h,
                        // ),
                        animatedTextScreen(),
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
                                alignment: Alignment.centerRight,
                                iconSize: 13,
                                onPressed: () {},
                                icon:
                                    const Icon(Icons.check_box_outline_blank)),
                            const Text(
                              "Remember Password",
                              style: TextStyle(
                                  fontSize: 13,
                                  color: AppColors.secondaryColor),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10.h,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 175.w,
                            ),
                            forgotPassword(() {
                              Navigator.of(context)
                                  .pushNamed("/reset_password");
                            }),
                          ],
                        ),
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
                        style: TextStyle(color: AppColors.secondaryColor),
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
                  ),
                  SizedBox(
                    height: 15.h,
                  ),
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

// Widget buildMarqueeText() {
//   return SizedBox(
//     height: 50.h,
//     child: Marquee(
//       text: 'Welcome to Reunite-Us',
//       style: const TextStyle(
//         fontWeight: FontWeight.bold,
//         fontSize: 24.0,
//         color: Colors.blueAccent,
//       ),
//       scrollAxis: Axis.horizontal,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       blankSpace: 20.0,
//       velocity: 100.0,
//       pauseAfterRound: const Duration(seconds: 1),
//       startPadding: 10.dm,
//       accelerationDuration: const Duration(seconds: 1),
//       accelerationCurve: Curves.linear,
//       decelerationDuration: const Duration(milliseconds: 500),
//       decelerationCurve: Curves.easeOut,
//     ),
//   );
// }

// Widget buildAnimatedText() {
//   return SizedBox(
//     width: 200.w,
//     child: DefaultTextStyle(
//       style: const TextStyle(
//         fontSize: 24.0,
//         fontWeight: FontWeight.bold,
//         color: AppColors.accentColor,
//       ),
//       child: AnimatedTextKit(
//         animatedTexts: [
//           WavyAnimatedText('Welcome to Reunite-Us'),
//         ],
//         isRepeatingAnimation: true,
//       ),
//     ),
//   );
// }
