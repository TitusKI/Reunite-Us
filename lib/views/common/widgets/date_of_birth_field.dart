import 'package:afalagi/bloc/report_form/report_form_bloc.dart';
import 'package:afalagi/bloc/shared_event.dart';
import 'package:afalagi/bloc/sign_up/sign_up_bloc.dart';
import 'package:afalagi/views/common/widgets/build_textfield.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

Widget dateField(BuildContext context, TextEditingController dateController,
    String? date, String? dateType) {
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
            if (picked != null && picked != DateTime.now()) {
              dateController.text = "${picked.toLocal()}".split(' ')[0];
              dateType == "birth"
                  ? context
                      .read<SignUpBloc>()
                      .add(DateEvent(dateOfBirth: dateController.text))
                  : context
                      .read<ReportFormBloc>()
                      .add(DateEvent(dateOfDisapperance: dateController.text));
            }
          },
          icon: const Icon(Icons.calendar_today)),
      controller: TextEditingController(text: date!),
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
