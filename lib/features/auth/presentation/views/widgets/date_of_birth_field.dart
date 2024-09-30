// ignore_for_file: use_build_context_synchronously

import 'package:afalagi/core/resources/shared_event.dart';
import 'package:afalagi/core/constants/presentation_export.dart';
import 'package:afalagi/features/auth/presentation/views/widgets/build_textfield.dart';

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
            DateTime minDate;
            if (dateType == "birth" && whoseBirth == 'userBirth') {
              minDate = DateTime(now.year - 10, now.month, now.day);
            } else if (dateType == "birth" && whoseBirth == 'missingBirth') {
              minDate = DateTime(now.year, now.month, now.day);
            } else {
              minDate = DateTime(now.year, now.month, now.day);
            }

            final DateTime? picked = await showDatePicker(
                context: context,
                initialDate: minDate,
                firstDate:
                    dateType == "birth" ? DateTime(1900) : DateTime(1800),
                lastDate: minDate);
            if (picked != null) {
              dateController.text = "${picked.toLocal()}".split(' ')[0];
              if (dateType == "birth") {
                if (whoseBirth == "missingBirth") {
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
              if (dateType == 'disapperance') {
                context
                    .read<ReportFormBloc>()
                    .add(DateEvent(dateOfDisapperance: dateController.text));
              }
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
