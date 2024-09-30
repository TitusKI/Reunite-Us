import 'package:intl/intl.dart';

int calculateAge(String birthDateStr) {
  final DateFormat formatter = DateFormat('yyyy-MM-ddTHH:mm:ss.SSS');
  final DateTime birthDate = formatter.parse(birthDateStr);
  final DateTime now = DateTime.now();
  int age = now.year - birthDate.year;
  if (now.month < birthDate.month ||
      (now.month == birthDate.month && now.day < birthDate.day)) {
    age--;
  }
  return age;
}

String formatDate(String dateString) {
  DateTime dateTime = DateTime.parse(dateString);
  DateFormat formatter = DateFormat('MMMM d, yyyy');
  return formatter.format(dateTime);
}
