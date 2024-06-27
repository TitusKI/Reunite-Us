import 'package:afalagi/bloc/welcome/welcome_bloc.dart';
import 'package:afalagi/main/global.dart';
import 'package:afalagi/views/common/values/colors.dart';
import 'package:afalagi/views/common/values/constant.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class Welcome extends StatefulWidget {
  const Welcome({super.key});

  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  PageController pageController = PageController(initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => WelcomeBloc(),
      child: Container(
        child: Scaffold(
          body: BlocBuilder<WelcomeBloc, WelcomeState>(
            builder: (context, state) {
              return Stack(
                alignment: Alignment.topCenter,
                children: [
                  PageView(
                    controller: pageController,
                    onPageChanged: (index) {
                      state.page = index;
                      BlocProvider.of<WelcomeBloc>(context).add(WelcomeEvent());
                    },
                    children: [
                      _page(
                          1,
                          context,
                          'Next',
                          "Welcome to Afalagi",
                          "Join our community to help reunite lost and missing people with their loved ones.",
                          "assets/welcome/welcome1.png"),
                      _page(
                          2,
                          context,
                          'Next',
                          "Find & Report",
                          "Use our app to locate missing persons or to report sightings and reunite families.",
                          "assets/welcome/welcome2.png"),
                      _page(
                          3,
                          context,
                          'Get Started',
                          "Community Support",
                          "Become part of a supportive community dedicated to reuniting lost people with their families.",
                          "assets/welcome/welcome3.png"),
                    ],
                  ),
                  Positioned(
                    bottom: 50.h,
                    child: DotsIndicator(
                      position: state.page,
                      dotsCount: 3,
                      mainAxisAlignment: MainAxisAlignment.center,
                      decorator: DotsDecorator(
                          activeColor: AppColors.accentColor,
                          color: AppColors.secondaryColor,
                          size: const Size.square(8.0),
                          activeSize: const Size(15.0, 8.0),
                          activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0))),
                    ),
                  ),
                ],
              );
            },
          ),
        ),
      ),
    );
  }

  Widget _page(int index, BuildContext context, String buttonName, String title,
      String subtitle, String imagePath) {
    return Column(
      children: [
        SizedBox(
          width: 345.w,
          height: 345.w,
          child: Image.asset(
            imagePath,
            fit: BoxFit.fitWidth,
          ),
        ),
        Container(
            child: Text(
          title,
          style: TextStyle(
            color: AppColors.primaryText,
            fontSize: 25.sp,
            fontWeight: FontWeight.normal,
          ),
        )),
        Container(
          width: 375.w,
          padding: EdgeInsets.only(left: 30.w, right: 30.w),
          child: Text(
            subtitle,
            style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 15.sp,
              fontWeight: FontWeight.normal,
            ),
          ),
        ),
        GestureDetector(
          onTap: () {
            if (index < 3) {
              pageController.animateToPage(index,
                  duration: const Duration(milliseconds: 500),
                  curve: Curves.easeIn);
            } else {
              // Navigator.of(context).push(
              //   MaterialPageRoute(
              //     builder: (context) => const MyHomePage(),
              //   ),
              // );
              Global.storageService
                  .setBool(AppConstant.STORAGE_DEVICE_OPEN_FIRST_TIME, true);
              print(
                  "The value is: ${Global.storageService.getDeviceFirstOpen()}");
              Navigator.of(context)
                  .pushNamedAndRemoveUntil("/sign_in", (route) => false);
            }
          },
          child: Container(
            margin: EdgeInsets.only(top: 100.h, left: 25.w, right: 25.w),
            width: 325.w,
            height: 50.h,
            decoration: BoxDecoration(
              color: AppColors.accentColor,
              borderRadius: BorderRadius.all(Radius.circular(15.w)),
              boxShadow: const [
                BoxShadow(
                  color: AppColors.accentColor,
                  spreadRadius: 1,
                  blurRadius: 2,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: Center(
              child: Text(
                buttonName,
                style: TextStyle(
                  color: AppColors.primaryBackground,
                  fontSize: 18.sp,
                  fontWeight: FontWeight.normal,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
