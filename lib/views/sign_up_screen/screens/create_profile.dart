import 'dart:io';

import 'package:afalagi/bloc/sign_up/sign_up_bloc.dart';
import 'package:afalagi/bloc/sign_up/sign_up_event.dart';
import 'package:afalagi/bloc/sign_up/sign_up_state.dart';
import 'package:afalagi/utils/controller/sign_up_controller.dart';

import 'package:afalagi/views/common/values/colors.dart';
import 'package:afalagi/views/common/widgets/build_textfield.dart';
import 'package:afalagi/views/common/widgets/common_widgets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import "package:flutter_screenutil/flutter_screenutil.dart";
import 'package:flutter_bloc/flutter_bloc.dart';

class CreateProfile extends StatefulWidget {
  const CreateProfile({super.key});

  @override
  State<CreateProfile> createState() => _CreateProfileState();
}

class _CreateProfileState extends State<CreateProfile> {
  late final File image;
  final List<String> genders = ["Male", "Female"];
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignUpBloc, SignUpStates>(
      listener: (context, state) {
        if (state.imagePickState == ImagePickState.initial) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text(
                state.errorImage!,
              ),
            ),
          );
        }
      },
      builder: (context, state) {
        String? selectedGender;
        String? phoneNumber = state.phoneNumber;
        String? dateOfBirth = state.dateOfBirth;
        TextEditingController _dateController = TextEditingController();
        if (state is GenderSelectionState) {
          selectedGender = state.selectedGender;
        }

        return Container(
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
                    Container(
                      padding: EdgeInsets.only(left: 25.w, right: 25.w),
                      margin: EdgeInsets.only(top: 50.h),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Column(
                            children: [
                              if (state.imagePickState ==
                                  ImagePickState.initial)
                                buildInitialInput(context),
                              if (state.imagePickState == ImagePickState.picked)
                                buildImagePreview(state.profileImage!),
                              if (state.imagePickState == ImagePickState.failed)
                                buildFailedInput(context, state.errorImage)
                              // the image is as for debugging not actual image
                            ],
                          ),
                          const SizedBox(height: 15),
                          reusableText("First Name"),
                          buildTextField(
                              "Enter your first name", "name", "user", (value) {
                            context
                                .read<SignUpBloc>()
                                .add(FirstNameEvent(value));
                          }),
                          reusableText("Middle Name"),
                          buildTextField(
                              "Enter your middle name", "name", "user",
                              (value) {
                            context
                                .read<SignUpBloc>()
                                .add(MiddleNameEvent(value));
                          }),
                          reusableText("Last Name"),
                          buildTextField("Enter your last name", "name", "user",
                              (value) {
                            context
                                .read<SignUpBloc>()
                                .add(LastNameEvent(value));
                          }),
                          reusableText("Location"),
                          buildTextField("city, State", "name", "user",
                              (value) {
                            context
                                .read<SignUpBloc>()
                                .add(LocationEvent(value));
                          }),
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
                            child: phoneNumberField(phoneNumber),
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
                      SignUpController(context).handleProfileBuild();
                      // Navigator.of(context).pushNamed("SignUp");
                      //SignUpController(context).handleEmailSignUp();
                    })
                  ],
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
  return ElevatedButton(
    onPressed: () {
      context.read<SignUpBloc>().add(PickImage());
    },
    child: const Text("Pick Image"),
  );
}

Widget buildImagePreview(File image) {
  return Column(
    children: [
      CircleAvatar(
        radius: 50,
        backgroundImage: FileImage(image),
      ),
      const SizedBox(
        height: 20,
      ),
      ElevatedButton(
          onPressed: () {}, child: const Text("Set as Profile Picture"))
    ],
  );
}

Widget buildFailedInput(BuildContext context, String? errorMsg) {
  return Column(
    children: [
      Text(errorMsg!),
      ElevatedButton(
        onPressed: () {
          // Handle failed input state action
        },
        child: Text('Retry'),
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

Widget phoneNumberField(String? phoneNumber) {
  return MyTextField(
      inputFormatters: [FilteringTextInputFormatter.digitsOnly],
      prefixIcon: const Icon(Icons.phone),
      controller: TextEditingController(text: phoneNumber.toString()),
      hintText: "Enter Phone Number",
      obscureText: false,
      keyboardType: TextInputType.number);
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
      hintText: "DD/MM/YYYY",
      obscureText: false,
      keyboardType: TextInputType.datetime);
}
