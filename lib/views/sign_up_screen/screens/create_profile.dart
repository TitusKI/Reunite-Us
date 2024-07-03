import 'dart:io';

import 'package:afalagi/bloc/sign_up/sign_up_bloc.dart';
import 'package:afalagi/bloc/sign_up/sign_up_event.dart';
import 'package:afalagi/bloc/sign_up/sign_up_state.dart';

import 'package:afalagi/views/common/values/colors.dart';
import 'package:afalagi/views/common/widgets/build_textfield.dart';
import 'package:afalagi/views/common/widgets/common_widgets.dart';
import 'package:afalagi/views/common/widgets/flutter_toast.dart';
import 'package:csc_picker/csc_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SignUpBloc, SignUpStates>(
      // listener: (context, state) {
      //   if (state.imagePickState == ImagePickState.initial) {
      //     ScaffoldMessenger.of(context).showSnackBar(
      //       SnackBar(
      //         content: Text(
      //           state.errorImage!,
      //         ),
      //       ),
      //     );
      //   }
      // },
      builder: (context, state) {
        String? selectedGender;
        PhoneNumber? number = state.phoneNumber;
        String dateOfBirth = state.dateOfBirth;
        TextEditingController _dateController = TextEditingController();
        if (state is GenderSelectionState) {
          selectedGender = state.selectedGender;
        }

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
                                      state.profileImage!, context),
                                if (state.imagePickState ==
                                    ImagePickState.failed)
                                  buildFailedInput(context, state.errorImage)
                                // the image is as for debugging not actual image
                              ],
                            ),
                            const SizedBox(height: 15),
                            reusableText("First Name"),
                            // buildTextField(
                            //     "Enter your first name", "name", "user",
                            //     (value) {
                            //   context
                            //       .read<SignUpBloc>()
                            //       .add(FirstNameEvent(value!));
                            //   return null;
                            // }),
                            reusableText("Middle Name"),
                            // buildTextField(
                            //     "Enter your middle name", "name", "user",
                            //     (value) {
                            //   context
                            //       .read<SignUpBloc>()
                            //       .add(MiddleNameEvent(value!));
                            //   return value;
                            // }),
                            reusableText("Last Name"),
                            // buildTextField(
                            //     "Enter your last name", "name", "user",
                            //     (value) {
                            //   context
                            //       .read<SignUpBloc>()
                            //       .add(LastNameEvent(value!));
                            //   return value;
                            // }),
                            reusableText("Location"),
                            cscPicker(context),
                            const SizedBox(
                              height: 10,
                            ),
                            reusableText("Gender"),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.9,
                              child: genderTextField(
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
                              child: dateOfBirthField(
                                  context, _dateController, dateOfBirth),
                            ),
                          ],
                        ),
                      ),
                      buildLogInAndRegButton("Build Profile", true, () {
                        if (_formKey.currentState!.validate()) {
                          // SignUpController(context).handleProfileBuild();
                        }

                        // Navigator.of(context).pushNamedAndRemoveUntil(
                        //     '/sign_in', (Route<dynamic> route) => false);
                        // Navigator.of(context).pushNamed("SignUp");
                        //SignUpController(context).handleEmailSignUp();
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

CSCPicker cscPicker(BuildContext context) {
  return CSCPicker(
    showStates: true,
    showCities: true,
    flagState: CountryFlag.ENABLE,
    dropdownDecoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: Colors.white,
      border: Border.all(color: Colors.grey.shade300, width: 1),
    ),
    disabledDropdownDecoration: BoxDecoration(
      borderRadius: const BorderRadius.all(Radius.circular(10)),
      color: Colors.grey.shade300,
      border: Border.all(color: Colors.grey.shade300, width: 1),
    ),
    selectedItemStyle: const TextStyle(
      color: Colors.black,
      fontSize: 14,
    ),
    dropdownHeadingStyle: const TextStyle(
      color: Colors.black,
      fontSize: 17,
      fontWeight: FontWeight.bold,
    ),
    dropdownItemStyle: const TextStyle(
      color: Colors.black,
      fontSize: 14,
    ),
    countrySearchPlaceholder: "Search Country",
    stateSearchPlaceholder: "Search State",
    citySearchPlaceholder: "Search City",
    countryDropdownLabel: "Country",
    stateDropdownLabel: "State",
    cityDropdownLabel: "City",
    onCountryChanged: (value) {
      context.read<SignUpBloc>().add(
            CountryChanged(value),
          );
    },
    onStateChanged: (value) {
      context.read<SignUpBloc>().add(StateChanged(value));
    },
    onCityChanged: (value) {
      context.read<SignUpBloc>().add(CityChanged(value));
    },
  );
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

Widget buildImagePreview(File image, BuildContext context) {
  return Center(
    child: Column(
      children: [
        Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.2,
          child: Center(
            child: Column(children: [
              CircleAvatar(
                radius: 50,
                backgroundImage: FileImage(image),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  ElevatedButton(
                    style: const ButtonStyle(
                        backgroundColor:
                            WidgetStatePropertyAll(AppColors.accentColor)),
                    onPressed: () {
                      toastInfo(msg: "Profile setted succesfully");
                    },
                    child: const Text(
                      "Set as Profile",
                      style: TextStyle(
                        color: AppColors.primaryBackground,
                      ),
                    ),
                  ),
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

Widget genderTextField(
    String? selectedGender, List<String> genders, BuildContext context) {
  return MyTextField(
      prefixIcon: const Icon(Icons.person),
      suffixIcon: DropdownButton<String>(
        value: selectedGender,
        icon: const Icon(Icons.arrow_drop_down),
        iconSize: 24,
        elevation: 16,
        underline: Container(
          height: 0,
          color: Colors.transparent,
        ),
        items: genders.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem(
            value: value,
            child: Text(value),
          );
        }).toList(),
        onChanged: (String? value) {
          context.read<SignUpBloc>().add(GenderEvent(value!));
        },
      ),
      controller: TextEditingController(text: selectedGender),
      hintText: "Select Gender",
      obscureText: false,
      keyboardType: TextInputType.none);
}

Widget phoneNumberFiel(String? phoneNumber) {
  return MyTextField(
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      prefixIcon: const Icon(Icons.phone),
      controller: TextEditingController(text: phoneNumber.toString()),
      hintText: "Enter Phone Number",
      obscureText: false,
      keyboardType: TextInputType.number);
}

Widget phoneNumberField(BuildContext context, PhoneNumber? phoneNumber) {
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
      selectorType: PhoneInputSelectorType.BOTTOM_SHEET,
    ),
    ignoreBlank: false,
    autoValidateMode: AutovalidateMode.disabled,
    selectorTextStyle: const TextStyle(
      color: AppColors.primaryText,
    ),
    initialValue: phoneNumber,
    textFieldController: TextEditingController(),
    inputBorder: const OutlineInputBorder(),
    onSaved: (PhoneNumber number) {
      print("on Saved: $number");
    },
  );
}

Widget dateOfBirthField(BuildContext context,
    TextEditingController dateController, String? dateOfBirth) {
  return MyTextField(
      prefixIcon: const Icon(Icons.date_range),
      suffixIcon: IconButton(
          onPressed: () async {
            final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: DateTime.now(),
                firstDate: DateTime(1900),
                lastDate: DateTime(2101));
            if (picked != null && picked != DateTime.now()) {
              dateController.text = "${picked.toLocal()}".split(' ')[0];
              context
                  .read<SignUpBloc>()
                  .add(DateOfBirthEvent(dateController.text));
            }
          },
          icon: const Icon(Icons.calendar_today)),
      controller: TextEditingController(text: dateOfBirth),
      validator: (validate) {
        if (validate!.isEmpty) {
          return "Please fill in this field";
        }
        return null;
      },
      hintText: "DD/MM/YYYY",
      obscureText: false,
      keyboardType: TextInputType.datetime);
}
