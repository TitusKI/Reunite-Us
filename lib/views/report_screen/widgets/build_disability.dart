// ignore_for_file: prefer_const_constructors

import 'package:afalagi/routes/export.dart';
import 'package:afalagi/views/common/values/colors.dart';
import 'package:afalagi/views/common/widgets/build_textfield.dart';
import 'package:flutter/rendering.dart';

// return MyTextField(
//   controller: TextEditingController(),
//   hintText: hintText,
//   obscureText: false,
//   keyboardType: TextInputType.none,
// );import 'package:flutter/material.dart';

Widget buildDisabilityTextFormField({
  required String disabilityType,
  required BuildContext context,
  required TextEditingController controller,
  required List<String> disabilities,
  required String hintText,
}) {
  final LayerLink layerLink = LayerLink();
  return BlocListener<ReportFormBloc, ReportFormState>(
    listener: (context, state) {
      if (disabilityType == "physical") {
        if (state.selectedPhysicalDisability.contains('None')) {
          controller.clear();
        } else {
          controller.text = state.selectedPhysicalDisability.join(', ');
        }
      } else {
        if (state.selectedMentalDisability.contains('None')) {
          controller.clear();
        } else {
          controller.text = state.selectedMentalDisability.join(', ');
        }
      }
    },
    child: Column(
      children: [
        CompositedTransformFollower(
          link: layerLink,
          child: MyTextField(
            controller: controller,
            suffixIcon: IconButton(
              icon: const Icon(Icons.arrow_drop_down),
              onPressed: () async {
                final RenderBox button =
                    context.findRenderObject() as RenderBox;
                final RenderBox overlay =
                    Overlay.of(context).context.findRenderObject() as RenderBox;
                final RelativeRect position = RelativeRect.fromRect(
                  Rect.fromPoints(
                    button.localToGlobal(button.size.topCenter(Offset.zero),
                        ancestor: overlay),
                    button.localToGlobal(button.size.centerRight(Offset.zero),
                        ancestor: overlay),
                  ),
                  Offset.zero & overlay.size,
                );

                await showMenu<String>(
                  context: context,
                  position: position,
                  items: disabilities.map((String choice) {
                    return PopupMenuItem<String>(
                      value: choice,
                      child: BlocBuilder<ReportFormBloc, ReportFormState>(
                        builder: (context, state) {
                          final state = context.read<ReportFormBloc>().state;
                          bool isChecked = disabilityType == "physical"
                              ? state.selectedPhysicalDisability
                                  .contains(choice)
                              : state.selectedMentalDisability.contains(choice);

                          return CheckboxListTile(
                            activeColor: AppColors.accentColor,
                            //  checkColor: AppColors.accentColor,
                            title: Text(choice),
                            value: isChecked,
                            onChanged: (bool? value) {
                              if (disabilityType == "physical") {
                                context.read<ReportFormBloc>().add(
                                    ReportFormEvent(
                                        physicalDisability: choice));
                              } else {
                                context.read<ReportFormBloc>().add(
                                    ReportFormEvent(mentalDisability: choice));
                              }
                            },
                          );
                        },
                      ),
                    );
                  }).toList(),
                );
              },
            ),
            readOnly: true,
            hintText: hintText,
            obscureText: false,
            keyboardType: TextInputType.none,
          ),
        ),
        BlocBuilder<ReportFormBloc, ReportFormState>(
          builder: (context, state) {
            if (disabilityType == "physical") {
              if (state.selectedPhysicalDisability.contains('Other')) {
                final initial = state.otherPhysicalDisability;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: initial,
                    onChanged: (value) {
                      context
                          .read<ReportFormBloc>()
                          .add(ReportFormEvent(otherPhysicalDisability: value));
                    },
                    decoration: const InputDecoration(
                      labelText: 'Specify Other',
                      border: OutlineInputBorder(),
                    ),
                  ),
                );
              }
              return Container();
            } else {
              if (state.selectedMentalDisability.contains('Other')) {
                final initial = state.otherMentalDisability;
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: TextFormField(
                    initialValue: initial,
                    onChanged: (value) {
                      context
                          .read<ReportFormBloc>()
                          .add(ReportFormEvent(otherMentalDisability: value));
                    },
                    decoration: const InputDecoration(
                      labelText: 'Specify Other',
                      border: OutlineInputBorder(),
                    ),
                  ),
                );
              }
              return Container();
            }
          },
        ),
      ],
    ),
  );
}
