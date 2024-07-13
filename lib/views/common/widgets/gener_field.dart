import 'package:afalagi/bloc/report_form/report_form_bloc.dart';
import 'package:afalagi/bloc/sign_up/sign_up_bloc.dart';
import 'package:afalagi/views/common/widgets/build_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget dropDownField(
    {String? selected,
    List<String>? dropDown,
    BuildContext? context,
    String? hintText,
    required String keyName}) {
  return MyTextField(
    readOnly: true,
    prefixIcon: const Icon(Icons.person),
    suffixIcon: DropdownButton<String>(
      icon: const Icon(Icons.arrow_drop_down),
      iconSize: 24,
      elevation: 16,
      underline: Container(
        height: 0,
        color: Colors.transparent,
      ),
      items: dropDown!.map<DropdownMenuItem<String>>((String value) {
        return DropdownMenuItem(
          value: value,
          child: Text(value),
        );
      }).toList(),
      onChanged: (String? value) {
        switch (keyName) {
          case 'gender':
            context!.read<SignUpBloc>().add(GenderEvent(value!));
            break;
          case 'hairColor':
            context!
                .read<ReportFormBloc>()
                .add(ReportFormEvent(onHairColor: value));
            break;
          case 'educationalLevel':
            context!
                .read<ReportFormBloc>()
                .add(ReportFormEvent(onEducationalLevel: value));
            break;
          case 'skinColor':
            context!
                .read<ReportFormBloc>()
                .add(ReportFormEvent(onSkinColor: value));
            break;
          default:
            return;
        }
      },
    ),
    controller: TextEditingController(text: selected),
    hintText: hintText!,
    // dropDown == ["Male", "Female"] ? "Select Gender" : "Has Disability?",
    obscureText: false,
    keyboardType: TextInputType.none,
    validator: (validate) {
      if (validate == null || validate.isEmpty) {
        return dropDown == ["Male", "Female"] ? "Please select a gender" : null;
      }
      return null;
    },
  );
}
