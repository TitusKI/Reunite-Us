// ignore_for_file: use_build_context_synchronously

import 'package:afalagi/bloc/profile/create_profile/create_profile_bloc.dart';
import 'package:afalagi/bloc/shared_event.dart';
import 'package:afalagi/routes/export.dart';
import 'package:afalagi/views/common/widgets/build_textfield.dart';

Widget dateField(
    {required BuildContext context,
    required TextEditingController dateController,
    required String? date,
    required String? dateType,
    String? whoseBirth}) {
  return MyTextField(
      prefixIcon: const Icon(Icons.date_range),
      suffixIcon: IconButton(
          onPressed: () async {
            final DateTime now = DateTime.now();
            final DateTime minDate = dateType == "birth"
                ? DateTime(now.year - 10, now.month, now.day)
                : DateTime.now();

            final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: minDate,
                firstDate:
                    dateType == "birth" ? DateTime(1900) : DateTime(1800),
                lastDate: minDate);
            if (picked != null) {
              dateController.text = "${picked.toLocal()}".split(' ')[0];
              if (dateType == "birth") {
                if (whoseBirth == "missingDate") {
                  context
                      .read<ReportFormBloc>()
                      .add(DateEvent(dateOfBirth: dateController.text));
                } else {
                  context
                      .read<CreateProfileBloc>()
                      .add(DateEvent(dateOfBirth: dateController.text));
                  print("Users Date is :${dateController.text}");
                }
              }

              context
                  .read<ReportFormBloc>()
                  .add(DateEvent(dateOfDisapperance: dateController.text));
            }
          },
          icon: const Icon(Icons.calendar_today)),
      controller: TextEditingController(text: dateController.text),
      validator: (validate) {
        if (validate!.isEmpty) {
          return "Please fill in this field";
        }
        return null;
      },
      readOnly: true,
      hintText: "Select Date",
      obscureText: false,
      keyboardType: TextInputType.datetime);
}
