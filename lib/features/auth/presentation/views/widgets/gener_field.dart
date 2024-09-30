import 'package:afalagi/features/user/presentation/bloc/create_profile/create_profile_bloc.dart';
import 'package:afalagi/features/user/presentation/bloc/create_profile/create_profile_event.dart';
import 'package:afalagi/features/post/presentation/bloc/report_form/report_form_bloc.dart';
import 'package:afalagi/features/post/presentation/bloc/report_form/report_form_event.dart';
import 'package:afalagi/core/util/controller/enum_utility.dart';
import 'package:afalagi/core/util/controller/enums.dart';
import 'package:afalagi/features/auth/presentation/views/widgets/build_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget dropDownField<T extends Enum>(
    {String? selected,
    List<T>? dropDown,
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
      items: dropDown!.map<DropdownMenuItem<String>>((T value) {
        return DropdownMenuItem(
          value: value.toShortString(),
          child: Text(value.toShortString()),
        );
      }).toList(),
      onChanged: (String? value) {
        switch (keyName) {
          case 'genderR':
            final gender = stringToGender(value!);
            context!
                .read<ReportFormBloc>()
                .add(ReportFormEvent(onGender: gender));
            break;
          case 'gender':
            final gender = stringToGender(value!);
            context!.read<CreateProfileBloc>().add(GenderEvent(gender));
            break;
          case 'hairColor':
            final hairColor = stringToHairColor(value!);
            context!
                .read<ReportFormBloc>()
                .add(ReportFormEvent(onHairColor: hairColor));
            break;
          case 'educationalLevel':
            final educationLevel = stringToEducationalLevel(value!);
            context!
                .read<ReportFormBloc>()
                .add(ReportFormEvent(onEducationalLevel: educationLevel));
            break;
          case 'posterRelation':
            final posterRelation = stringToPosterRelation(value!);
            context!
                .read<ReportFormBloc>()
                .add(ReportFormEvent(onPosterRelation: posterRelation));
            break;
          case 'maritalStatus':
            final maritalStatus = stringToMaritalStatus(value!);
            context!
                .read<ReportFormBloc>()
                .add(ReportFormEvent(onMaritalStatus: maritalStatus));
            break;
          case 'skinColor':
            final skinColor = stringToSkinColor(value!);
            context!
                .read<ReportFormBloc>()
                .add(ReportFormEvent(onSkinColor: skinColor));
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
        return dropDown == Gender.values ? "Please select a gender" : null;
      }
      return null;
    },
  );
}
