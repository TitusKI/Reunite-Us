import 'package:afalagi/bloc/report_form/report_form_bloc.dart';
import 'package:afalagi/bloc/sign_up/sign_up_bloc.dart';

import 'package:afalagi/utils/controller/sign_up_controller.dart';
import 'package:afalagi/views/report_screen/screens/add_report.dart';
import 'package:afalagi/views/report_screen/widgets/build_disability.dart';
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
  int index = 0;
  final formKey = GlobalKey<FormState>();
  final List<String> physicalDisabilities = [
    'None',
    'Blindness',
    'Deafness',
    'Mobility Issue',
    'Other'
  ];
  final List<String> mentalDisabilities = [
    'None',
    'Psycho',
    'Authism',
    'Other'
  ];
  final List<String> educationalLevel = [
    "No Formal Education",
    "Kindergarten",
    "Primary School",
    "Secondary School",
    "Associate Degree",
    "Bachelors Degree",
    "Masters Degree",
    "Doctoral Degree"
  ];

  final SignUpController _signUpController = SignUpController();

  final TextEditingController physicalDisabilityController =
      TextEditingController();
  final TextEditingController mentalDisabilityController =
      TextEditingController();
  final TextEditingController recongizableFeatureController =
      TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<ReportFormBloc, ReportFormState>(
        builder: (context, state) {
          String? selected = state.educationalLevel;

          return Form(
            key: formKey,
            child: Container(
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
              padding: const EdgeInsets.all(16.0),
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
                      controller: recongizableFeatureController,
                      hintText: "Enter the recongnizable feature",
                      prefixIcon: const Icon(Icons.person),
                      inputType: TextInputType.name,
                      func: (value) {
                        context.read<ReportFormBloc>().add(
                            ReportFormEvent(onRecongnizableFeature: value));
                      },
                      formType: "report form",
                      context: context),
                  const SizedBox(height: 15.0),
                  reusableText("Physical Disability:"),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: buildDisabilityTextFormField(
                          disabilityType: "physical",
                          context: context,
                          controller: physicalDisabilityController,
                          disabilities: physicalDisabilities,
                          hintText: "Select Physical Disability")),
                  const SizedBox(height: 15.0),
                  reusableText("Mental Disability:"),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: buildDisabilityTextFormField(
                          disabilityType: "mental",
                          context: context,
                          controller: mentalDisabilityController,
                          disabilities: mentalDisabilities,
                          hintText: "Select Mental Disability")),
                  const SizedBox(height: 15.0),
                  reusableText("Description:"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: formField(
                        fieldName: "description",
                        value: state.description,
                        controller: descriptionController,
                        hintText: "Enter description",
                        prefixIcon: const Icon(Icons.description),
                        inputType: TextInputType.multiline,
                        func: (value) {
                          context
                              .read<ReportFormBloc>()
                              .add(ReportFormEvent(onDescription: value));
                        },
                        formType: "report form",
                        context: context),
                  ),
                  const SizedBox(height: 15.0),
                  reusableText("Educational Level:"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: dropDownField(
                        selected: selected,
                        dropDown: educationalLevel,
                        context: context,
                        hintText: "Select educational level",
                        keyName: 'educationalLevel'),
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
                        controller: _signUpController.videoLinkController,
                        hintText: "Enter any video link if you have a message",
                        prefixIcon: const Icon(Icons.link),
                        inputType: TextInputType.text,
                        func: (value) {
                          context
                              .read<ReportFormBloc>()
                              .add(ReportFormEvent(onVideoLink: value));
                        },
                        formType: "report form",
                        context: context),
                  ),
                  reusableText("Upload Photo"),
                  BlocBuilder<SignUpBloc, SignUpStates>(
                    builder: (context, state) {
                      return Column(
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
                      );
                    },
                  ),
                  const SizedBox(height: 25.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      pageViewButton(
                          context: context,
                          index: index,
                          buttonName: "Back",
                          formKey: formKey),
                      pageViewButton(
                          context: context,
                          index: 2,
                          buttonName: "Report",
                          formKey: formKey)
                    ],
                  )
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
