import 'package:afalagi/bloc/verification/verification_bloc.dart';
import 'package:afalagi/views/common/values/colors.dart';
import 'package:afalagi/views/common/widgets/common_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpVerification extends StatefulWidget {
  final String? title;

  const SignUpVerification({super.key, this.title});

  @override
  State<SignUpVerification> createState() => _SignUpVerificationState();
}

class _SignUpVerificationState extends State<SignUpVerification> {
  late VerificationBloc _verificationBloc;
  final TextEditingController _pinCodeController = TextEditingController();
  final String? title = "Sign up Verification";
  late String email;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _verificationBloc = BlocProvider.of<VerificationBloc>(context);
    final args = ModalRoute.of(context)!.settings.arguments as String;
    setState(() {
      email = args;
    });
  }

  @override
  void dispose() {
    _verificationBloc.add(ResetCode());
    _pinCodeController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarLarge(title!),
      body: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(
              height: 15,
            ),
            reusableText(
                "Please Enter the 6 digit \nverification code sent \nto your email"),
            const SizedBox(
              height: 35,
            ),
            Container(
                padding: const EdgeInsets.all(20.0),
                margin: const EdgeInsets.all(8.0),
                child: buildPinCodeField(
                    context, title, _pinCodeController, email)),
            const SizedBox(
              height: 15,
            ),
            Center(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  reusableText("Didn't receive code?"),
                  GestureDetector(
                    child: const Center(
                      child: Text(
                        'Resend Now',
                        style: TextStyle(
                            color: AppColors.accentColor, fontSize: 15),
                      ),
                    ),
                    onTap: () {
                      _verificationBloc.add(ResendCode(email));
                    },
                  )
                ],
              ),
            ),
            BlocBuilder<VerificationBloc, VerificationState>(
              builder: (context, state) {
                bool isButtonEnabled = state is VerificationCodeValid;
                return buildLogInAndRegButton("Verify", isButtonEnabled, () {
                  // final code = (state as VerificationCodeValid).code;
                  // context.read<VerificationBloc>().add(SubmitCode(code));

                  // context.read<VerificationBloc>().add(CodeChanged(code));
                });
              },
            )
          ],
        ),
      ),
    );
  }
}
