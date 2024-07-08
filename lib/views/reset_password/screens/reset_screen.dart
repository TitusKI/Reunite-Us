import 'package:afalagi/bloc/reset_password/reset_password_bloc.dart';
import 'package:afalagi/bloc/shared_event.dart';
import 'package:afalagi/utils/controller/reset_password_controller.dart';

import 'package:afalagi/views/common/values/colors.dart';
import 'package:afalagi/views/common/widgets/common_widgets.dart';
import 'package:afalagi/views/sign_up_screen/widgets/sign_up_widgets.dart';
import 'package:flutter/material.dart';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ResetScreen extends StatefulWidget {
  const ResetScreen({super.key});

  @override
  State<ResetScreen> createState() => _ResetScreenState();
}

class _ResetScreenState extends State<ResetScreen> {
  final _formKey = GlobalKey<FormState>();
  late ResetPasswordBloc _resetPasswordBloc;
  final ResetPasswordController _resetPasswordController =
      ResetPasswordController();
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _resetPasswordBloc = BlocProvider.of<ResetPasswordBloc>(context);
  }

  @override
  void dispose() {
    _resetPasswordBloc.add(ResetEmail());

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarLarge("Sign In Help"),
      body: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              SizedBox(
                height: 25.h,
              ),
              Center(
                child: Text(
                  "Forgot Password",
                  style: TextStyle(
                      fontWeight: FontWeight.w900,
                      color: AppColors.primaryText,
                      fontSize: 25.sp),
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              Center(
                child: reusableText(
                  "Enter your email address below\n and we'll send you a code to reset",
                ),
              ),
              SizedBox(
                height: 15.h,
              ),
              BlocBuilder<ResetPasswordBloc, ResetPasswordState>(
                builder: (context, state) {
                  return formField(
                    formType: "reset",
                    func: (value) {
                      context.read<ResetPasswordBloc>().add(EmailEvent(value));
                    },
                    value: state.email,
                    controller: _resetPasswordController.emailController,
                    textType: "email",
                    inputType: TextInputType.visiblePassword,
                    hintText: "Enter your email",
                    prefixIcon: const Icon(Icons.email),
                    fieldName: "email",
                    context: context,
                  );
                },
              ),
              buildLogInAndRegButton("Get Code", true, () {
                if (_formKey.currentState!.validate()) {
                  Navigator.of(context).pushNamed("/reset_verification");
                } // ResetPasswordController().handleEmailReset();
              }),
              const SizedBox(
                height: 14,
              ),
              const Center(
                child: Text(
                  'Can\'t reset your password?',
                  style: TextStyle(
                      fontSize: 15,
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.w600),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
