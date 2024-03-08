import 'dart:io';

import 'package:afalagi/bloc/profile/create_profile/create_profile_bloc.dart';
import 'package:afalagi/bloc/shared_event.dart';
import 'package:afalagi/routes/export.dart';
import 'package:afalagi/views/common/values/colors.dart';
import 'package:afalagi/views/common/widgets/build_textfield.dart';
import 'package:afalagi/views/common/widgets/flutter_toast.dart';

Widget buildInitialInput(BuildContext context) {
  // print("Image Pick Initial State");
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
                  // style: const ButtonStyle(),
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

Widget buildImagePreview(File image, BuildContext context, String imageType) {
  // print("ImagePreview");
  bool isPressed = false;
  return Center(
    child: Column(
      children: [
        SizedBox(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.24,
          child: Center(
            child: Column(children: [
              imageType == "profile"
                  ? CircleAvatar(
                      radius: 50,
                      backgroundImage: FileImage(image),
                    )
                  : MyTextField(
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
  return Column(
    children: [
      Text(errorMsg!),
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
