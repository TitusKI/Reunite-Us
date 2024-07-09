// ignore_for_file: unused_field

import 'package:afalagi/bloc/report_form/report_form_bloc.dart';
import 'package:afalagi/bloc/sign_up/sign_up_bloc.dart';

import 'package:afalagi/utils/controller/sign_up_controller.dart';
import 'package:afalagi/views/report_screen/screens/add_report.dart';
import 'package:afalagi/views/sign_up_screen/screens/create_profile.dart';
import 'package:flutter/material.dart';
import 'package:afalagi/views/common/widgets/common_widgets.dart';
import 'package:afalagi/views/common/widgets/gener_field.dart';
import 'package:afalagi/views/sign_up_screen/widgets/sign_up_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormPageTwoWidget extends StatefulWidget {
  const FormPageTwoWidget({super.key});

  @override
  State<FormPageTwoWidget> createState() => _FormPageTwoWidgetState();
}

class _FormPageTwoWidgetState extends State<FormPageTwoWidget> {
  String? _country;

  String? _state;

  String? _city;

  int index = 0;

  final List<String> disabilitys = ["Yes", "No"];

  final SignUpController _signUpController = SignUpController();

  final TextEditingController _dateController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<ReportFormBloc, ReportFormState>(
        builder: (context, state) {
          String? selected = state.selected;

          return Container(
            alignment: Alignment.center,

            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(15.0),
              boxShadow: const [
                BoxShadow(
                  color: Colors.black26,
                  blurRadius: 10.0,
                  offset: Offset(0, 5),
                ),
              ],
            ),
            padding: EdgeInsets.all(16.0),
            // padding: EdgeInsets.all(15.w),
            margin: EdgeInsets.all(15.h),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                reusableText("Recongnizable Feature:"),
                formField(
                    fieldName: "recongizableFeature",
                    value: state.recongnizableFeature,
                    controller: _signUpController.firstNameController,
                    hintText: "Enter the recongnizable feature",
                    prefixIcon: const Icon(Icons.person),
                    inputType: TextInputType.name,
                    func: (value) {
                      context
                          .read<ReportFormBloc>()
                          .add(ReportFormEvent(onRecongnizableFeature: value));
                    },
                    formType: "report",
                    context: context),
                const SizedBox(height: 15.0),
                reusableText("Physical Disability:"),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: dropDownField(selected, disabilitys, context),
                ),
                const SizedBox(height: 15.0),
                reusableText("Mental Disability:"),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: dropDownField(selected, disabilitys, context),
                ),
                const SizedBox(height: 15.0),
                reusableText("Description:"),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: formField(
                      fieldName: "description",
                      value: state.description,
                      controller: _signUpController.firstNameController,
                      hintText: "Enter description",
                      prefixIcon: const Icon(Icons.description),
                      inputType: TextInputType.multiline,
                      func: (value) {
                        context
                            .read<ReportFormBloc>()
                            .add(ReportFormEvent(onDescription: value));
                      },
                      formType: "report",
                      context: context),
                ),
                reusableText("Educational Level:"),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: formField(
                      fieldName: "educationalLevel",
                      value: state.educationalLevel,
                      controller: _signUpController.firstNameController,
                      hintText: "Enter educational level",
                      prefixIcon: const Icon(Icons.person),
                      inputType: TextInputType.text,
                      func: (value) {
                        context
                            .read<ReportFormBloc>()
                            .add(ReportFormEvent(onEducationalLevel: value));
                      },
                      formType: "report",
                      context: context),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                reusableText("Video Message:"),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: formField(
                      fieldName: "videoMessage",
                      value: state.videoLink,
                      controller: _signUpController.firstNameController,
                      hintText: "Enter any video link if you have a message",
                      prefixIcon: const Icon(Icons.link),
                      inputType: TextInputType.text,
                      func: (value) {
                        context
                            .read<ReportFormBloc>()
                            .add(ReportFormEvent(onVideoLink: value));
                      },
                      formType: "report",
                      context: context),
                ),
                reusableText("Upload Photo"),
                Column(
                  children: [
                    if (state.imagePickState == ImagePickState.initialy)
                      buildInitialInput(context),
                    if (state.imagePickState == ImagePickState.picked)
                      buildImagePreview(
                          state.profileImage!, context, "missingImage"),
                    if (state.imagePickState == ImagePickState.failed)
                      buildFailedInput(context, state.errorImage)
                    // the image is as for debugging not actual image
                  ],
                ),
                const SizedBox(height: 25.0),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    pageViewButton(
                        context: context, index: index, buttonName: "Back"),
                    pageViewButton(
                        context: context, index: 2, buttonName: "Report")
                  ],
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
