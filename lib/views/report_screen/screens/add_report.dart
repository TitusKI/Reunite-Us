// ignore_for_file: unused_field

import 'package:afalagi/bloc/report_form/report_form_bloc.dart';
import 'package:afalagi/routes/routes.dart';

import 'package:afalagi/views/common/values/colors.dart';
import 'package:afalagi/views/common/widgets/common_widgets.dart';
import 'package:afalagi/views/report_screen/widgets/form_page_one_widget.dart';
import 'package:afalagi/views/report_screen/widgets/form_page_two_widget.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

PageController _pageController = PageController(initialPage: 0);

// ignore: must_be_immutable
class AddReport extends StatelessWidget {
  const AddReport({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: AppColors.primaryBackground,
        appBar: buildAppBarLarge("Report Missing Person"),
        body: BlocBuilder<ReportFormBloc, ReportFormState>(
          builder: (context, state) {
            return Stack(
              alignment: Alignment.topCenter,
              children: [
                PageView(
                  physics: const NeverScrollableScrollPhysics(),
                  controller: _pageController,
                  onPageChanged: (index) {
                    state.page = index;
                    context.read<ReportFormBloc>().add(const ReportFormEvent());
                  },
                  children: const [FormPageOneWidget(), FormPageTwoWidget()],
                ),
              ],
            );
          },
        ));
  }
}

ElevatedButton pageViewButton(
    {required BuildContext context,
    required int index,
    required String buttonName,
    required formKey}) {
  return ElevatedButton(
    style: ButtonStyle(
        alignment: Alignment.centerRight,
        backgroundColor: WidgetStateProperty.all(AppColors.accentColor)),
    onPressed: () {
      if (index == 1) {
        // if (formKey.currentState!.validate()) {
        //   formKey.currentState!.save();
        _pageController.animateToPage(index,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
        // }
      } else if (index == 0) {
        _pageController.animateToPage(index,
            duration: const Duration(milliseconds: 300), curve: Curves.easeIn);
      } else {
        if (formKey.currentState!.validate()) {
          formKey.currentState!.save();
          Navigator.of(context).pushNamedAndRemoveUntil(
              AppRoutes.SIGN_IN, (Route<dynamic> route) => false);
        }
      }
    },
    child: Text(
      buttonName,
      style: TextStyle(
        color: AppColors.primaryBackground,
        fontSize: 18.sp,
        fontWeight: FontWeight.normal,
      ),
    ),
  );
}
