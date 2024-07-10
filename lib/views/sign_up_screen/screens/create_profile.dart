// ignore_for_file: unused_field

import 'dart:io';

import 'package:afalagi/bloc/shared_event.dart';
import 'package:afalagi/bloc/sign_up/sign_up_bloc.dart';
import 'package:afalagi/core/routes/names.dart';
import 'package:afalagi/utils/controller/sign_up_controller.dart';
import 'package:afalagi/views/common/values/colors.dart';
import 'package:afalagi/views/common/widgets/common_widgets.dart';
import 'package:afalagi/views/common/widgets/date_of_birth_field.dart';
import 'package:afalagi/views/common/widgets/flutter_toast.dart';
import 'package:afalagi/views/common/widgets/gener_field.dart';
import 'package:afalagi/views/sign_up_screen/widgets/location_form_field.dart';
import 'package:afalagi/views/sign_up_screen/widgets/sign_up_widgets.dart';
import 'package:flutter/material.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  late final File image;
  final List<String> genders = ["Male", "Female"];
  final _formKey = GlobalKey<FormState>();
  final SignUpController _signUpController = SignUpController();
  SignUpBloc _signUpBloc = SignUpBloc();
  String? _country;
  String? _state;
  String? _city;
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _signUpBloc = BlocProvider.of<SignUpBloc>(context);
  }

  @override
  void dispose() {
    _signUpBloc.add(SignUpReset());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpStates>(
      builder: (context, state) {
        String? selectedGender = state.selected;
        PhoneNumber? number = state.phoneNumber;
        String dateOfBirth = state.dateOfBirth;
        TextEditingController _dateController = TextEditingController();
        // if (state is GenderSelectionState) {
        //   selectedGender = state.selectedGender;
        // }

        return Form(
          key: _formKey,
          child: Container(
            color: AppColors.primaryBackground,
            child: SafeArea(
              child: Scaffold(
                backgroundColor: AppColors.primaryBackground,
                appBar: buildAppBarLarge("Create Your Profile"),
                body: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      SizedBox(
                        height: 20.h,
                      ),
                      Center(
                          child: reusableText(
                              "Create Your Initial Profile To Get Started")),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: EdgeInsets.only(left: 25.w, right: 25.w),
                        margin: EdgeInsets.only(top: 50.h),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            reusableText("Upload Photo"),
                            Column(
                              children: [
                                if (state.imagePickState ==
                                    ImagePickState.initialy)
                                  buildInitialInput(context),
                                if (state.imagePickState ==
                                    ImagePickState.picked)
                                  buildImagePreview(
                                      state.profileImage!, context, "profile"),
                                if (state.imagePickState ==
                                    ImagePickState.failed)
                                  buildFailedInput(context, state.errorImage)
                                // the image is as for debugging not actual image
                              ],
                            ),
                            const SizedBox(height: 15),
                            reusableText("First Name"),
                            formField(
                                fieldName: "firstName",
                                value: state.firstName,
                                controller:
                                    _signUpController.firstNameController,
                                textType: "profile",
                                hintText: "Enter your first name",
                                prefixIcon: const Icon(Icons.person),
                                inputType: TextInputType.name,
                                func: (value) {
                                  context
                                      .read<SignUpBloc>()
                                      .add(NameChangedEvent(firstName: value));
                                },
                                formType: "sign up",
                                context: context),
                            reusableText("Middle Name"),
                            formField(
                                fieldName: "middleName",
                                value: state.middleName,
                                controller:
                                    _signUpController.middleNameController,
                                textType: "profile",
                                hintText: "Enter your middle name",
                                prefixIcon: const Icon(Icons.person),
                                inputType: TextInputType.name,
                                func: (value) {
                                  context
                                      .read<SignUpBloc>()
                                      .add(NameChangedEvent(middleName: value));
                                },
                                formType: "sign up",
                                context: context),
                            reusableText("Last Name"),
                            formField(
                                fieldName: "lastName",
                                value: state.lastName,
                                controller:
                                    _signUpController.lastNameController,
                                textType: "profile",
                                hintText: "Enter your last name",
                                prefixIcon: const Icon(Icons.person),
                                inputType: TextInputType.name,
                                func: (value) {
                                  context
                                      .read<SignUpBloc>()
                                      .add(NameChangedEvent(lastName: value));
                                },
                                formType: "sign up",
                                context: context),
                            reusableText("Location"),
                            LocationFormField(
                              // Provide a unique key if necessary
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
                            // CscPicker(context),
                            const SizedBox(
                              height: 10,
                            ),
                            reusableText("Gender"),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: dropDownField(
                                  selectedGender, genders, context),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            reusableText("Phone Number"),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: phoneNumberField(context, number),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            reusableText("Date Of Birth"),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: dateField(context, _dateController,
                                  dateOfBirth, "birth"),
                            ),
                          ],
                        ),
                      ),
                      buildLogInAndRegButton("Build Profile", true, () {
                        if (_formKey.currentState!.validate()) {
                          _formKey.currentState!.save();
                          Navigator.of(context).pushNamed(AppRoutes.SIGN_IN);
                          // SignUpController(context).handleProfileBuild();
                        }
                      })
                    ],
                  ),
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}

Widget buildInitialInput(BuildContext context) {
  return Center(
    child: Column(
      children: [
        Container(
          color: AppColors.cardColor,
          child: Center(
            child: Column(
              children: [
                IconButton(
                  // color: AppColors.accentColor,
                  // color: AppColors.accentColor,
                  style: const ButtonStyle(
                      backgroundColor:
                          WidgetStatePropertyAll(AppColors.accentColor)),
                  onPressed: () {
                    context.read<SignUpBloc>().add(PickImage());
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

Widget buildImagePreview(File image, BuildContext context, String imageType) {
  bool isPressed = false;
  return Center(
    child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.2,
          child: Center(
            child: Column(children: [
              imageType == "profile"
                  ? CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(image),
                    )
                  : Text(image.path),
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
                        context.read<SignUpBloc>().add(PickImage());
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
  return Column(
    children: [
      Text(errorMsg!),
      ElevatedButton(
        style: const ButtonStyle(
            backgroundColor: WidgetStatePropertyAll(AppColors.accentColor)),
        onPressed: () {
          context.read<SignUpBloc>().add(PickImage());
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

Widget phoneNumberField(BuildContext context, PhoneNumber? phoneNumber) {
  // final state = context.read<SignUpBloc>().state;

  return InternationalPhoneNumberInput(
    onInputChanged: (PhoneNumber number) {
      context.read<SignUpBloc>().add(PhoneNoChanged(number));
    },
    onInputValidated: (bool value) {
      context.read<SignUpBloc>().add(
            PhoneNoValidationChanged(value),
          );
    },
    selectorConfig: const SelectorConfig(
      selectorType: PhoneInputSelectorType.DIALOG,
    ),
    ignoreBlank: false,
    autoValidateMode: AutovalidateMode.disabled,
    selectorTextStyle: const TextStyle(
      color: AppColors.primaryText,
    ),
    initialValue: phoneNumber,
    textFieldController: TextEditingController(),
    inputBorder: const OutlineInputBorder(),
    inputDecoration: InputDecoration(
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),
        borderSide: const BorderSide(color: AppColors.cardColor),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(20),
        borderSide: BorderSide(color: Theme.of(context).colorScheme.secondary),
      ),
      fillColor: AppColors.cardColor,
      filled: true,
      hintText: "Enter your phone number",
      hintStyle: const TextStyle(
        color: Color.fromARGB(115, 88, 85, 85),
      ),
    ),
    keyboardType: TextInputType.number,
  );
}
