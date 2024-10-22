import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:afalagi/features/post/presentation/bloc/report_form/report_form_bloc.dart';
import 'package:afalagi/features/post/presentation/bloc/report_form/report_form_event.dart';
import 'package:afalagi/features/post/presentation/bloc/report_form/report_form_state.dart';
import 'package:afalagi/core/util/controller/enums.dart';
import 'package:afalagi/config/theme/colors.dart';
import 'package:afalagi/features/auth/presentation/views/widgets/build_textfield.dart';

Widget buildDisabilityTextFormField<T extends Enum>({
  required String disabilityType,
  required BuildContext context,
  required TextEditingController controller,
  required List<T> disabilities,
  required String hintText,
}) {
  final LayerLink layerLink = LayerLink();

  return BlocListener<ReportFormBloc, ReportFormState>(
    listener: (context, state) {
      List<String> selectedValues;

      if (disabilityType == "physical") {
        selectedValues = state.selectedPhysicalDisability
            .map((e) => e.toShortString())
            .toList();
        if (selectedValues.contains('None')) {
          selectedValues = ['None'];
        }
      } else if (disabilityType == "mental") {
        selectedValues = state.selectedMentalDisability
            .map((e) => e.toShortString())
            .toList();
        if (selectedValues.contains('None')) {
          selectedValues = ['None'];
        }
      } else {
        selectedValues =
            state.selectedMedicalIssues.map((e) => e.toShortString()).toList();
        if (selectedValues.contains('None')) {
          selectedValues = ['None'];
        }
      }

      controller.text = selectedValues.join(', ');
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

                await showMenu<T>(
                  context: context,
                  position: position,
                  items: disabilities.map((T choice) {
                    return PopupMenuItem<T>(
                      value: choice,
                      child: BlocBuilder<ReportFormBloc, ReportFormState>(
                        builder: (context, state) {
                          bool isChecked;
                          if (disabilityType == 'physical') {
                            isChecked = state.selectedPhysicalDisability
                                .contains(choice);
                          } else if (disabilityType == 'medical') {
                            isChecked =
                                state.selectedMedicalIssues.contains(choice);
                          } else {
                            isChecked =
                                state.selectedMentalDisability.contains(choice);
                          }

                          return CheckboxListTile(
                            activeColor: AppColors.accentColor,
                            title: Text(choice.toShortString()),
                            value: isChecked,
                            onChanged: (bool? value) {
                              if (choice.toShortString() == 'None' &&
                                  value == true) {
                                // Uncheck all selections when "None" is selected
                                if (disabilityType == "physical") {
                                  context.read<ReportFormBloc>().add(
                                        const ReportFormEvent(
                                          physicalDisability:
                                              PhysicalDisability.None,
                                        ),
                                      );
                                } else if (disabilityType == "medical") {
                                  context.read<ReportFormBloc>().add(
                                        const ReportFormEvent(
                                          medicalIssues: MedicalIssues.None,
                                        ),
                                      );
                                } else {
                                  context.read<ReportFormBloc>().add(
                                        const ReportFormEvent(
                                          mentalDisability:
                                              MentalDisability.None,
                                        ),
                                      );
                                }
                              } else if (choice.toShortString() == 'Other' &&
                                  value == true) {
                                // Set "Other" and show the "Specify Other" field
                                if (disabilityType == "physical") {
                                  context.read<ReportFormBloc>().add(
                                        const ReportFormEvent(
                                          physicalDisability:
                                              PhysicalDisability.Other,
                                        ),
                                      );
                                } else if (disabilityType == "medical") {
                                  context.read<ReportFormBloc>().add(
                                        const ReportFormEvent(
                                          medicalIssues: MedicalIssues.Other,
                                        ),
                                      );
                                } else {
                                  context.read<ReportFormBloc>().add(
                                        const ReportFormEvent(
                                          mentalDisability:
                                              MentalDisability.Other,
                                        ),
                                      );
                                }
                              } else {
                                // Add the selected choice to the list
                                if (disabilityType == "physical") {
                                  context.read<ReportFormBloc>().add(
                                        ReportFormEvent(
                                          physicalDisability:
                                              choice as PhysicalDisability,
                                        ),
                                      );
                                } else if (disabilityType == "medical") {
                                  context.read<ReportFormBloc>().add(
                                        ReportFormEvent(
                                          medicalIssues:
                                              choice as MedicalIssues,
                                        ),
                                      );
                                } else {
                                  context.read<ReportFormBloc>().add(
                                        ReportFormEvent(
                                          mentalDisability:
                                              choice as MentalDisability,
                                        ),
                                      );
                                }
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
            bool showSpecifyOtherField = false;
            String initialValue = '';

            if (disabilityType == "physical") {
              if (state.selectedPhysicalDisability
                  .contains(PhysicalDisability.Other)) {
                showSpecifyOtherField = true;
                initialValue = state.otherPhysicalDisability!;
              }
              if (state.selectedPhysicalDisability
                  .contains(PhysicalDisability.None)) {
                showSpecifyOtherField = false;
                // initialValue = state.otherPhysicalDisability;
              }
            } else if (disabilityType == "mental") {
              if (state.selectedMentalDisability
                  .contains(MentalDisability.Other)) {
                showSpecifyOtherField = true;
                initialValue = state.otherMentalDisability!;
              }
              if (state.selectedMentalDisability
                  .contains(MentalDisability.None)) {
                showSpecifyOtherField = false;
                // initialValue = state.otherPhysicalDisability;
              }
            } else if (disabilityType == "medical") {
              if (state.selectedMedicalIssues.contains(MedicalIssues.Other)) {
                showSpecifyOtherField = true;
                initialValue = state.otherMedicalIssues!;
              }
              if (state.selectedMedicalIssues.contains(MedicalIssues.None)) {
                showSpecifyOtherField = false;
                // initialValue = state.otherMedicalIssues;
              }
            }

            return showSpecifyOtherField
                ? Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: TextFormField(
                      initialValue: initialValue,
                      onChanged: (value) {
                        if (disabilityType == "physical") {
                          context.read<ReportFormBloc>().add(
                                ReportFormEvent(otherPhysicalDisability: value),
                              );
                        } else if (disabilityType == "mental") {
                          context.read<ReportFormBloc>().add(
                                ReportFormEvent(otherMentalDisability: value),
                              );
                        } else {
                          context.read<ReportFormBloc>().add(
                                ReportFormEvent(otherMedicalIssues: value),
                              );
                        }
                      },
                      decoration: const InputDecoration(
                        labelText: 'Specify Other',
                        border: OutlineInputBorder(),
                      ),
                    ),
                  )
                : Container();
          },
        ),
      ],
    ),
  );
}
