// ignore_for_file: unused_field

import 'package:afalagi/bloc/report_form/report_form_bloc.dart';
import 'package:afalagi/bloc/shared_event.dart';
import 'package:afalagi/bloc/sign_up/sign_up_bloc.dart';

import 'package:afalagi/utils/controller/sign_up_controller.dart';
import 'package:afalagi/views/common/widgets/date_of_birth_field.dart';
import 'package:afalagi/views/report_screen/screens/add_report.dart';

import 'package:flutter/material.dart';
import 'package:afalagi/views/common/widgets/common_widgets.dart';

import 'package:afalagi/views/sign_up_screen/widgets/location_form_field.dart';
import 'package:afalagi/views/sign_up_screen/widgets/sign_up_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FormPageOneWidget extends StatefulWidget {
  const FormPageOneWidget({super.key});

  @override
  State<FormPageOneWidget> createState() => _FormPageOneWidgetState();
}

class _FormPageOneWidgetState extends State<FormPageOneWidget> {
  int index = 1;
  String? _country;

  String? _state;

  String? _city;

  final List<String> genders = ["Male", "Female"];

  final SignUpController _signUpController = SignUpController();

  final TextEditingController _dateController = TextEditingController();
  final AddReport _addReport = const AddReport();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<ReportFormBloc, ReportFormState>(
        builder: (context, state) {
          String dateOfDisapperance = state.dateOfDisapperance;

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
            padding: const EdgeInsets.all(16.0),
            // padding: EdgeInsets.all(15.w),
            margin: EdgeInsets.all(15.h),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                reusableText("Full Name:"),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: formField(
                      fieldName: "fullName",
                      value: state.fullName,
                      controller: _signUpController.firstNameController,
                      hintText: "Enter missing person full name",
                      prefixIcon: const Icon(Icons.person),
                      inputType: TextInputType.name,
                      func: (value) {
                        context
                            .read<ReportFormBloc>()
                            .add(NameChangedEvent(fullName: value));
                      },
                      formType: "report",
                      context: context),
                ),
                reusableText("Age:"),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: formField(
                      fieldName: "age",
                      value: state.age.toString(),
                      controller: _signUpController.firstNameController,
                      hintText: "Enter missing person age",
                      prefixIcon: const Icon(Icons.person),
                      inputType: TextInputType.number,
                      func: (value) {
                        context
                            .read<SignUpBloc>()
                            .add(ReportFormEvent(onAge: int.parse(value)));
                      },
                      formType: "report",
                      context: context),
                ),
                reusableText("Date of Disapperance:"),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: dateField(context, _dateController, dateOfDisapperance,
                      "disapperance"),
                ),
                const SizedBox(height: 15.0),
                reusableText("Last Known Location:"),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: LocationFormField(
                    context: context,
                    onSaved: (value) {
                      _country = value?['country'];
                      _state = value?['state'];
                      _city = value?['city'];
                    },
                    validator: (value) {
                      if (value?['country'] == null) {
                        return "Please select a valid location";
                      }

                      return null;
                    },
                  ),
                ),
                const SizedBox(
                  height: 15.0,
                ),
                const SizedBox(height: 15.0),
                reusableText("Clothing Description:"),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: formField(
                      fieldName: "clothingDescription",
                      value: state.clothingDescription,
                      controller: _signUpController.firstNameController,
                      hintText:
                          "Enter clothing description (color and type of clothes)",
                      prefixIcon: const Icon(Icons.description_rounded),
                      inputType: TextInputType.multiline,
                      func: (value) {
                        context
                            .read<ReportFormBloc>()
                            .add(ReportFormEvent(onClothingDescription: value));
                      },
                      formType: "report",
                      context: context),
                ),
                reusableText("Height:"),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: formField(
                      fieldName: "height",
                      value: state.height.toString(),
                      controller: _signUpController.firstNameController,
                      hintText: "Enter missing person height here",
                      prefixIcon: const Icon(Icons.height),
                      inputType:
                          const TextInputType.numberWithOptions(decimal: true),
                      func: (value) {
                        context.read<ReportFormBloc>().add(
                            ReportFormEvent(onHeight: double.parse(value)));
                      },
                      formType: "report",
                      context: context),
                ),
                reusableText("Hair Color:"),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: formField(
                      fieldName: "hairColor",
                      value: state.hairColor,
                      controller: _signUpController.firstNameController,
                      hintText: "Enter color of the hair",
                      prefixIcon: const Icon(Icons.color_lens_rounded),
                      inputType: TextInputType.text,
                      func: (value) {
                        context
                            .read<ReportFormBloc>()
                            .add(ReportFormEvent(onHairColor: value));
                      },
                      formType: "report",
                      context: context),
                ),
                reusableText("Skin Color:"),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: formField(
                      fieldName: "skinColor",
                      value: state.skinColor,
                      controller: _signUpController.firstNameController,
                      hintText: "Enter color of the skin",
                      prefixIcon: const Icon(Icons.color_lens_rounded),
                      inputType: TextInputType.text,
                      func: (value) {
                        context
                            .read<ReportFormBloc>()
                            .add(ReportFormEvent(onSkinColor: value));
                      },
                      formType: "report",
                      context: context),
                ),
                const SizedBox(height: 25.0),
                Center(
                  child: pageViewButton(
                      context: context, index: index, buttonName: "Next"),
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
