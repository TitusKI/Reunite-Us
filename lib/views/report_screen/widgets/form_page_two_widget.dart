import 'dart:io';

// import 'package:afalagi/bloc/create_profile/create_profile_state.dart';
import 'package:afalagi/bloc/report_form/report_form_bloc.dart';
import 'package:afalagi/bloc/report_form/report_form_event.dart';
import 'package:afalagi/bloc/report_form/report_form_state.dart';
import 'package:afalagi/bloc/shared_event.dart';
import 'package:afalagi/bloc/upload_cubit/upload_cubit.dart';
import 'package:afalagi/model/missing_person.dart';
import 'package:afalagi/utils/controller/enum_utility.dart';
import 'package:afalagi/utils/controller/enums.dart';

import 'package:afalagi/utils/controller/sign_up_controller.dart';
import 'package:afalagi/views/common/values/colors.dart';
import 'package:afalagi/views/common/widgets/build_textfield.dart';
import 'package:afalagi/views/common/widgets/flutter_toast.dart';
import 'package:afalagi/views/report_screen/screens/add_report.dart';
import 'package:afalagi/views/report_screen/widgets/build_disability.dart';
// import 'package:afalagi/views/sign_up_screen/widgets/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:afalagi/views/common/widgets/common_widgets.dart';
import 'package:afalagi/views/common/widgets/gener_field.dart';
import 'package:afalagi/views/sign_up_screen/widgets/sign_up_widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';

class FormPageTwoWidget extends StatefulWidget {
  const FormPageTwoWidget({super.key});

  @override
  State<FormPageTwoWidget> createState() => _FormPageTwoWidgetState();
}

class _FormPageTwoWidgetState extends State<FormPageTwoWidget> {
  int index = 0;
  final formKey = GlobalKey<FormState>();

  final SignUpController _signUpController = SignUpController();

  final TextEditingController physicalDisabilityController =
      TextEditingController();
  final TextEditingController mentalDisabilityController =
      TextEditingController();
  final TextEditingController medicalIssuesController = TextEditingController();

  final TextEditingController recongizableFeatureController =
      TextEditingController();
  final TextEditingController descriptionController = TextEditingController();
  late ReportFormBloc _reportFormBloc;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    //   final UserRepository repository = UserRepository();
    _reportFormBloc = BlocProvider.of<ReportFormBloc>(context);
    // _createProfileBloc = CreateProfileBloc(widget.userRepository);
  }

  void _handleMissingPost() {
    final missingPerson = MissingPerson(
        maritalStatus: _reportFormBloc.state.maritalStatus!,
        posterRelation: _reportFormBloc.state.posterRelation!,
        dateOfBirth: _reportFormBloc.state.dateOfBirth,
        firstName: _reportFormBloc.state.firstName,
        middleName: _reportFormBloc.state.middleName,
        lastName: _reportFormBloc.state.lastName,
        description: _reportFormBloc.state.description,
        lastSeenLocation: _reportFormBloc.state.location,
        lastSeenDate: _reportFormBloc.state.dateOfDisappearance,
        languageSpoken: _reportFormBloc.state.languageSpoken!,
        nationality: _reportFormBloc.state.nationality,
        hairColor: _reportFormBloc.state.hairColor!,
        skinColor: _reportFormBloc.state.skinColor!,
        recognizableFeatures: _reportFormBloc.state.recognizableFeature,
        physicalDisability: _reportFormBloc.state.selectedPhysicalDisability,
        otherPhysicalDisability: _reportFormBloc.state.otherPhysicalDisability,
        mentalDisability: _reportFormBloc.state.selectedMentalDisability,
        otherMentalDisability: _reportFormBloc.state.otherMentalDisability,
        medicalIssues: _reportFormBloc.state.selectedMedicalIssues,
        otherMedicalIssue: _reportFormBloc.state.otherMedicalIssues,
        gender: _reportFormBloc.state.gender!,
        educationalLevel: _reportFormBloc.state.educationalLevel!);
    final postImages = _reportFormBloc.state.postImages;
    final legalDocs = _reportFormBloc.state.legalDocuments;
    // final videoMessage = _reportFormBloc.state
    _reportFormBloc.add(MissingPersonPost(
        missingPerson: missingPerson,
        postImages: postImages!,
        legalDocs: legalDocs!));
    // _createProfileBloc
    //     .add(ProfileSubmitEvent(userProfile: userProfile, file: file!));
  }

  // void _handleProfile() {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();
  //     final userProfile = UserProfile(
  //       firstName: _signUpController.firstNameController.text,
  //       middleName: _signUpController.middleNameController.text,
  //       lastName: _signUpController.lastNameController.text,
  //       birthDate: dateController.text,
  //       country: _createProfileBloc.state.country,
  //       state: _createProfileBloc.state.state,
  //       city: _createProfileBloc.state.city,
  //       phoneNumber: phoneNumberController.text,
  //       gender: _createProfileBloc.state.selected!.value,
  //     );
  //     final file = _createProfileBloc.state.profileImage;
  //     _createProfileBloc
  //         .add(ProfileSubmitEvent(userProfile: userProfile, file: file!));
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: BlocBuilder<ReportFormBloc, ReportFormState>(
        builder: (context, state) {
          String? selectedEducation = state.educationalLevel != null
              ? educationalLevelToString(state.educationalLevel!)
              : "";
          print("SelectedEducation is ");
          print(selectedEducation);
          String? selectedMarital = state.maritalStatus != null
              ? maritalStatusToString(state.maritalStatus!)
              : "";
          print("Selected Marital is ");
          print(selectedMarital);

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
                      value: state.recognizableFeature,
                      controller: recongizableFeatureController,
                      hintText: "Enter the recongnizable feature",
                      prefixIcon: const Icon(Icons.person),
                      inputType: TextInputType.name,
                      func: (value) {
                        context
                            .read<ReportFormBloc>()
                            .add(ReportFormEvent(onRecognizableFeature: value));
                      },
                      formType: "report form",
                      context: context),
                  const SizedBox(height: 15.0),
                  reusableText("Medical Issues:"),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: buildDisabilityTextFormField(
                          disabilityType: "medical",
                          context: context,
                          controller: medicalIssuesController,
                          disabilities: MedicalIssues.values,
                          hintText: "Select Medical Issues")),
                  const SizedBox(height: 15.0),
                  reusableText("Physical Disability:"),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: buildDisabilityTextFormField(
                          disabilityType: "physical",
                          context: context,
                          controller: physicalDisabilityController,
                          disabilities: PhysicalDisability.values,
                          hintText: "Select Physical Disability")),
                  const SizedBox(height: 15.0),
                  reusableText("Mental Disability:"),
                  SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: buildDisabilityTextFormField(
                          disabilityType: "mental",
                          context: context,
                          controller: mentalDisabilityController,
                          disabilities: MentalDisability.values,
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
                  reusableText("Marital Status:"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: dropDownField(
                        selected: selectedMarital,
                        dropDown: MaritalStatus.values,
                        context: context,
                        hintText: "Select Marital Status",
                        keyName: "maritalStatus"),
                  ),
                  const SizedBox(height: 15.0),
                  reusableText("Educational Level:"),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.9,
                    child: dropDownField(
                        selected: selectedEducation,
                        dropDown: EducationalLevel.values,
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
                  BlocBuilder<ReportFormBloc, ReportFormState>(
                    builder: (context, state) {
                      // Check if the state is null
                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          buildInitialInput(context),
                          if (state.imagePickState ==
                              MissignImagePickState.picked)
                            buildImagePreview(
                                state.postImages!, context, "missingImage"),
                          if (state.imagePickState ==
                              MissignImagePickState.failed)
                            buildFailedInput(context, state.errorImage)
                          // the image is as for debugging not actual image
                        ],
                      );
                    },
                  ),
                  reusableText("Legal Document"),
                  BlocBuilder<UploadCubit, UploadState>(
                    builder: (context, state) {
                      return Padding(
                        padding: const EdgeInsets.all(16.0),
                        child: Column(
                          children: [
                            // File path display
                            Container(
                              color: AppColors.cardColor,
                              child: Row(
                                children: [
                                  Expanded(
                                    child: TextField(
                                      controller: TextEditingController(
                                          text: state.filePath),
                                      decoration: InputDecoration(
                                        labelText: 'File Path',
                                        suffixIcon: IconButton(
                                          icon: const Icon(Icons.attach_file),
                                          onPressed: () => context
                                              .read<UploadCubit>()
                                              .pickFile(),
                                        ),
                                      ),
                                      readOnly: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(height: 16),
                            ElevatedButton.icon(
                              onPressed: () =>
                                  context.read<UploadCubit>().uploadFile(),
                              icon: const Icon(Icons.upload_file),
                              label: const Text('Upload'),
                            ),
                            const SizedBox(height: 16),
                            // if (state.status == UploadStatus.loading)
                            //   const CircularProgressIndicator(),
                            // if (state.status == UploadStatus.success)
                            //   const Text('Upload successful!'),
                            // if (state.status == UploadStatus.error)
                            //   const Text('Upload failed!'),
                          ],
                        ),
                      );
                    },
                  ),

                  // SizedBox(height: 16),
                  // if (state.status == UploadStatus.loading)
                  //   CircularProgressIndicator(),
                  // if (state.status == UploadStatus.success)
                  //   Text('Upload successful!'),
                  // if (state.status == UploadStatus.error)
                  //   // Text('Upload failed!'),

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
                          formKey: formKey,
                          func: _handleMissingPost)
                    ],
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

Widget buildInitialInput(BuildContext context) {
  print("Image Pick Initial State");
  return Center(
    child: Column(
      children: [
        Container(
          color: AppColors.cardColor,
          child: Center(
            child: Column(
              children: [
                IconButton(
                  onPressed: () {
                    context.read<ReportFormBloc>().add(PickImage());
                  },
                  icon: const Icon(
                    Icons.upload,
                    weight: 10,
                  ),
                ),
                const Text(
                  "Upload a Photo",
                  style: TextStyle(
                      color: AppColors.primaryText,
                      fontWeight: FontWeight.w500,
                      fontSize: 15),
                )
              ],
            ),
          ),
        ),
      ],
    ),
  );
}

Widget buildImagePreview(XFile image, BuildContext context, String imageType) {
  print("ImagePreview");
  bool isPressed = false;
  return Center(
    child: Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.24,
          child: Center(
            child: Column(children: [
              MyTextField(
                  controller: TextEditingController(text: image.path),
                  hintText: "",
                  obscureText: false,
                  keyboardType: TextInputType.text),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  isPressed == false
                      ? ElevatedButton(
                          style: const ButtonStyle(
                              backgroundColor: WidgetStatePropertyAll(
                                  AppColors.accentColor)),
                          onPressed: () {
                            isPressed = true;
                            imageType == "profile"
                                ? toastInfo(msg: "Profile setted succesfully")
                                : toastInfo(
                                    msg: "Missing image setted succesfully");
                          },
                          child: const Text(
                            "Set",
                            style: TextStyle(
                              color: AppColors.primaryBackground,
                            ),
                          ),
                        )
                      : Container(),
                  ElevatedButton(
                      style: const ButtonStyle(
                          backgroundColor:
                              WidgetStatePropertyAll(AppColors.accentColor)),
                      onPressed: () {
                        context.read<ReportFormBloc>().add(PickImage());
                      },
                      child: const Text(
                        "Change",
                        style: TextStyle(
                          color: AppColors.primaryBackground,
                        ),
                      ))
                ],
              ),
            ]),
          ),
        ),
      ],
    ),
  );
}

Widget buildFailedInput(BuildContext context, String? errorMsg) {
  print(errorMsg);
  return Column(
    children: [
      Text(errorMsg ?? 'Unknown error'),
      ElevatedButton(
        style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.accentColor)),
        onPressed: () {
          context.read<ReportFormBloc>().add(PickImage());
        },
        child: const Text(
          'Retry',
          style: TextStyle(
            color: AppColors.primaryBackground,
          ),
        ),
      ),
    ],
  );
}
