// ignore_for_file: unused_field

import 'package:afalagi/features/post/presentation/bloc/report_form/report_form_bloc.dart';
import 'package:afalagi/features/post/presentation/bloc/report_form/report_form_event.dart';
import 'package:afalagi/features/post/presentation/bloc/report_form/report_form_state.dart';
import 'package:afalagi/core/resources/shared_event.dart';
import 'package:afalagi/core/util/controller/enum_utility.dart';
import 'package:afalagi/core/util/controller/enums.dart';

import 'package:afalagi/core/util/controller/sign_up_controller.dart';
import 'package:afalagi/features/auth/presentation/views/widgets/date_of_birth_field.dart';
import 'package:afalagi/features/auth/presentation/views/widgets/gener_field.dart';
import 'package:afalagi/features/post/presentation/views/report_screen/screens/add_report.dart';

import 'package:flutter/material.dart';
import 'package:afalagi/features/auth/presentation/views/widgets/common_widgets.dart';

import 'package:afalagi/features/auth/presentation/views/sign_up_screen/widgets/location_form_field.dart';
import 'package:afalagi/features/auth/presentation/views/sign_up_screen/widgets/sign_up_widgets.dart';
import 'package:flutter/services.dart';
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

  final SignUpController _signUpController = SignUpController();

  final TextEditingController _dateController = TextEditingController();
  final TextEditingController _dateOfBirthController = TextEditingController();
  // final SkinColor skinColor = Skincolor;
  final AddReport _addReport = const AddReport();
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<ReportFormBloc, ReportFormState>(
        builder: (context, state) {
          String dateOfDisapperance = state.dateOfDisappearance;
          String dateOfBirth = state.dateOfBirth;
          String selectedHairColor = state.hairColor != null
              ? hairColorToString(state.hairColor!)
              : '';
          String selectedSkinColor = state.skinColor != null
              ? skinColorToString(state.skinColor!)
              : '';
          String selectedGender =
              state.gender != null ? genderToString(state.gender!) : '';

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  reusableText("First Name:"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: formField(
                        textType: "report",
                        fieldName: "firstName",
                        value: state.firstName,
                        controller: _signUpController.firstNameController,
                        hintText: "Enter missing person first name",
                        prefixIcon: const Icon(Icons.person),
                        inputType: TextInputType.name,
                        func: (value) {
                          context
                              .read<ReportFormBloc>()
                              .add(NameChangedEvent(firstName: value));
                        },
                        formType: "report form",
                        context: context),
                  ),
                  reusableText("Middle Name:"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: formField(
                        textType: "report",
                        fieldName: "middleName",
                        value: state.middleName,
                        controller: _signUpController.middleNameController,
                        hintText: "Enter missing person middle name",
                        prefixIcon: const Icon(Icons.person),
                        inputType: TextInputType.name,
                        func: (value) {
                          context
                              .read<ReportFormBloc>()
                              .add(NameChangedEvent(middleName: value));
                        },
                        formType: "report form",
                        context: context),
                  ),
                  reusableText("Gender:"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: dropDownField(
                        selected: selectedGender,
                        dropDown: Gender.values,
                        context: context,
                        hintText: "Select gender",
                        keyName: "genderR"),
                  ),
                  reusableText("Last Name:"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: formField(
                        textType: "report",
                        fieldName: "lastName",
                        value: state.lastName,
                        controller: _signUpController.lastNameController,
                        hintText: "Enter missing person full name",
                        prefixIcon: const Icon(Icons.person),
                        inputType: TextInputType.name,
                        func: (value) {
                          context
                              .read<ReportFormBloc>()
                              .add(NameChangedEvent(lastName: value));
                        },
                        formType: "report form",
                        context: context),
                  ),
                  reusableText("Date of Birth:"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: dateField(
                        context: context,
                        dateController: _dateOfBirthController,
                        date: dateOfBirth,
                        dateType: "birth"),
                  ),
                  reusableText("Date of Disapperance:"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: dateField(
                        context: context,
                        dateController: _dateController,
                        date: dateOfDisapperance,
                        dateType: "disapperance"),
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
                        controller:
                            _signUpController.clothingDescriptionController,
                        hintText:
                            "Enter clothing description (color and type of clothes)",
                        prefixIcon: const Icon(Icons.description_rounded),
                        inputType: TextInputType.multiline,
                        func: (value) {
                          context.read<ReportFormBloc>().add(
                              ReportFormEvent(onClothingDescription: value));
                        },
                        formType: "report form",
                        context: context),
                  ),

                  reusableText("Nationality:"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: formField(
                        fieldName: "nationality",
                        value: state.nationality,
                        controller: _signUpController.nationalityController,
                        hintText: "Enter missing person nationality",
                        prefixIcon: const Icon(Icons.flag_rounded),
                        inputType: TextInputType.multiline,
                        func: (value) {
                          context
                              .read<ReportFormBloc>()
                              .add(ReportFormEvent(onNationality: value));
                        },
                        formType: "report form",
                        context: context),
                  ),
                  reusableText("Language Spoken:"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: formField(
                        fieldName: "language",
                        value: state.languageSpoken,
                        controller: _signUpController.languageSpokenController,
                        hintText: "Enter language spoken by missing person",
                        prefixIcon: const Icon(Icons.flag_rounded),
                        inputType: TextInputType.multiline,
                        func: (value) {
                          context
                              .read<ReportFormBloc>()
                              .add(ReportFormEvent(onLanguageSpoken: value));
                        },
                        formType: "report form",
                        context: context),
                  ),

                  reusableText("Height:"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: formField(
                        inputFormatters: [
                          FilteringTextInputFormatter.digitsOnly
                        ],
                        fieldName: "height",
                        value: state.height.toString(),
                        controller: _signUpController.heightController,
                        hintText: "Enter missing person height here",
                        prefixIcon: const Icon(Icons.height),
                        inputType: TextInputType.number,
                        func: (value) {
                          context.read<ReportFormBloc>().add(
                              ReportFormEvent(onHeight: double.parse(value)));
                        },
                        formType: "report form",
                        context: context),
                  ),
                  reusableText("Hair Color:"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: dropDownField(
                        selected: selectedHairColor,
                        dropDown: HairColor.values,
                        context: context,
                        hintText: "Select hair color",
                        keyName: "hairColor"),
                  ),
                  reusableText("Skin Color:"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: dropDownField(
                        selected: selectedSkinColor,
                        dropDown: SkinColor.values,
                        context: context,
                        hintText: "Select skin color",
                        keyName: 'skinColor'),
                  ),
                  // SizedBox(
                  //   width: MediaQuery.of(context).size.width * 0.9,
                  //   child: formField(
                  //       fieldName: "skinColor",
                  //       value: state.skinColor,
                  //       controller: _signUpController.skinColorController,
                  //       hintText: "Enter color of the skin",
                  //       prefixIcon: const Icon(Icons.color_lens_rounded),
                  //       inputType: TextInputType.text,
                  //       func: (value) {
                  //         context
                  //             .read<ReportFormBloc>()
                  //             .add(ReportFormEvent(onSkinColor: value));
                  //       },
                  //       formType: "report form",
                  //       context: context),
                  // ),
                  const SizedBox(height: 25.0),
                  Center(
                    child: pageViewButton(
                        context: context,
                        index: index,
                        buttonName: "Next",
                        formKey: formKey),
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
