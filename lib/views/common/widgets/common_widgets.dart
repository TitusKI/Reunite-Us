import 'package:afalagi/views/common/values/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:afalagi/bloc/verification/verification_bloc.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

AppBar buildAppBar(String type) {
  return AppBar(
    backgroundColor: Colors.transparent,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1.0),
      child: Container(
        color: AppColors.secondaryColor,
        // height defines the thickness of the line
        height: 1.0,
      ),
    ),
    title: Center(
      child: Text(type,
          style: TextStyle(
              color: AppColors.primaryText,
              fontSize: 16.sp,
              fontWeight: FontWeight.normal)),
    ),
  );
}

AppBar buildAppBarLarge(String type, {List<Widget> actions = const []}) {
  return AppBar(
    actions: actions,
    systemOverlayStyle:
        const SystemUiOverlayStyle(statusBarColor: AppColors.accentColor),
    toolbarHeight: 100.0,
    backgroundColor: AppColors.accentColor,
    elevation: 10,
    // backgroundColor: Colors.transparent,
    bottom: PreferredSize(
      preferredSize: const Size.fromHeight(1.0),
      child: Container(
        color: AppColors.accentColor,
        // height defines the thickness of the line
        height: 10.0,
      ),
    ),
    title: Center(
      child: Text(
        type,
        style: TextStyle(
          color: AppColors.primaryBackground,
          fontSize: 16.sp,
          fontWeight: FontWeight.normal,
        ),
      ),
    ),
  );
}

//Need Context for accesssing Bloc
Widget buildThirdPartyLogin(BuildContext context) {
  return Container(
    margin: EdgeInsets.only(top: 10.h, bottom: 5.h),
    padding: EdgeInsets.only(left: 35.w, right: 25.w),
    child: Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _reusableIcons("google"),
      ],
    ),
  );
}

Widget _reusableIcons(String iconName) {
  return GestureDetector(
    onTap: () {},
    child: SizedBox(
      width: 40.w,
      height: 40.w,
      child: Image.asset("assets/icons/$iconName.png"),
    ),
  );
}

Widget reusableText(String text) {
  return Container(
    margin: EdgeInsets.only(bottom: 5.h),
    child: Text(
      text,
      style: TextStyle(
        color: AppColors.primaryText,
        fontWeight: FontWeight.normal,
        fontSize: 14.sp,
      ),
    ),
  );
}

Widget buildTextField(String hintText, String textType, String iconName,
    void Function(String value)? func) {
  // final List<String> genders = ["Male", "Female", "Other"];
  return Container(
    // height and width of the textfield
    width: 325.w,
    height: 50.h,
    margin: EdgeInsets.only(bottom: 20.h),
    decoration: BoxDecoration(
      color: AppColors.secondaryColor,
      borderRadius: BorderRadius.all(
        Radius.circular(15.w),
      ),
      border: Border.all(color: AppColors.secondaryColor),
    ),
    child: Row(
      children: [
        Container(
          width: 16.w,
          height: 16.w,
          margin: EdgeInsets.only(left: 17.w),
          child: Image.asset(
            "assets/icons/$iconName.png",
            color: AppColors.primarySecondaryText,
          ),
        ),
        SizedBox(
          width: 270.w,
          height: 50.h,
          child: TextFormField(
            // sending the value user types on the textfield to the func
            onChanged: (value) => func!(value),
            keyboardType: TextInputType.multiline,
            decoration: InputDecoration(
              hintText: hintText,
              border: OutlineInputBorder(
                borderSide: BorderSide(
                  color: textType == 'search'
                      ? AppColors.primaryBackground
                      : Colors.transparent,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: textType == "search"
                      ? AppColors.primaryBackground
                      : Colors.transparent,
                ),
              ),
              enabledBorder: const OutlineInputBorder(
                borderSide: BorderSide(
                  color: Colors.transparent,
                ),
              ),
              hintStyle: const TextStyle(
                color: AppColors.secondaryText,
              ),
            ),
            style: TextStyle(
              color: AppColors.primaryText,
              fontFamily: "Avenir",
              fontSize: 12.sp,
              fontWeight: FontWeight.normal,
            ),
            autocorrect: false,
            obscureText: textType == "password" ? true : false,
          ),
        ),
      ],
    ),
  );
}

Widget forgotPassword(void Function()? forgfunc) {
  return GestureDetector(
    onTap: forgfunc,
    child: Text(
      "Forgot password?",
      style: TextStyle(
        fontWeight: FontWeight.w600,
        color: AppColors.accentColor,
        fontSize: 12.sp,
      ),
    ),
  );
}

Widget buildLogInAndRegButton(
    String buttonName, bool isButtonEnabled, void Function()? func) {
  return GestureDetector(
    onTap: isButtonEnabled ? func : null,
    child: Column(
      children: [
        Container(
            margin: EdgeInsets.only(
                left: 25.w,
                right: 25.w,
                top: isButtonEnabled == true ? 35.h : 20.h),
            width: 325.w,
            height: 50.h,
            decoration: BoxDecoration(
                color: isButtonEnabled == true
                    ? AppColors.accentColor
                    : AppColors.primarySecondaryText,
                borderRadius: BorderRadius.circular(15.w),
                border: Border.all(
                    color: isButtonEnabled == true
                        ? Colors.transparent
                        : AppColors.primarySecondaryText),
                boxShadow: [
                  BoxShadow(
                    spreadRadius: 1,
                    blurRadius: 2,
                    offset: const Offset(0, 1),
                    color: Colors.grey.withOpacity(0.1),
                  )
                ]),
            child: Center(
              child: Text(
                buttonName,
                style: TextStyle(
                    fontSize: 16.sp,
                    fontWeight: FontWeight.normal,
                    color: AppColors.primaryBackground),
              ),
            )),
      ],
    ),
  );
}

Widget buildPinCodeField(BuildContext context, String? title,
    TextEditingController controller, String email) {
  return BlocBuilder<VerificationBloc, VerificationState>(
    builder: (context, state) {
      if (state is VerificationLoading) {
        return const Center(child: CircularProgressIndicator());
      }
      if (state is VerificationFailure) {
        return Center(
            child: Text('Error: ${state.error}',
                style: const TextStyle(color: Colors.red)));
      }
      if (state is VerificationSuccess) {
        // Navigate to the next page after successful verification
        WidgetsBinding.instance.addPostFrameCallback((_) {
          Navigator.of(context).pushNamed("/create_profile");
        });
      }
      return PinCodeTextField(
        controller: controller,
        keyboardType: TextInputType.number,
        inputFormatters: [FilteringTextInputFormatter.digitsOnly],
        appContext: context,
        length: 6,
        animationType: AnimationType.fade,
        pinTheme: PinTheme(
          shape: PinCodeFieldShape.box,
          borderRadius: BorderRadius.circular(5),
          fieldHeight: 50,
          fieldWidth: 40,
          activeFillColor: Colors.white,
          inactiveFillColor: Colors.white,
          selectedFillColor: Colors.white,
          activeColor: AppColors.accentColor,
          inactiveColor: Colors.grey,
          selectedColor: AppColors.accentColor,
        ),
        animationDuration: const Duration(milliseconds: 300),
        backgroundColor: Colors.blue.shade50,
        enableActiveFill: true,
        onChanged: (value) {
          context.read<VerificationBloc>().add(CodeChanged(value));
          // context.read<VerificationBloc>().add(CodeChanged(value));
        },
        onCompleted: (value) {
          context.read<VerificationBloc>().add(SubmitCode(value, email));
          context.read<VerificationBloc>().add(CodeChanged(value));
          title == ""
              ? Navigator.of(context).pushNamed("/reset_successful")
              : Navigator.of(context).pushNamed("/create_profile");
          //  context.read<VerificationBloc>().add(SubmitCode(value));
        },
      );
    },
  );
}
