import 'package:afalagi/bloc/verification/verification_bloc.dart';
import 'package:afalagi/views/common/values/colors.dart';
import 'package:afalagi/views/common/widgets/common_widgets.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ResetVerification extends StatefulWidget {
  const ResetVerification({super.key});

  @override
  State<ResetVerification> createState() => _ResetVerificationState();
}

class _ResetVerificationState extends State<ResetVerification> {
  late VerificationBloc _verificationBloc;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _verificationBloc = BlocProvider.of<VerificationBloc>(context);
  }

  @override
  void dispose() {
    _verificationBloc.add(ResetCode());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBarLarge("Reset Verification"),
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
                child: buildPinCodeField(context)),
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
                    onTap: () {},
                  )
                ],
              ),
            ),
            BlocBuilder<VerificationBloc, VerificationState>(
              builder: (context, state) {
                bool isButtonEnabled = state is VerificationCodeValid;
                return buildLogInAndRegButton("Proceed", isButtonEnabled, () {
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
