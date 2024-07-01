import 'package:intl_phone_number_input/intl_phone_number_input.dart';

abstract class SignUpEvents {
  const SignUpEvents();
}

class LocationEvent extends SignUpEvents {
  final String location;
  const LocationEvent(this.location);
}

class FirstNameEvent extends SignUpEvents {
  final String firstname;
  const FirstNameEvent(this.firstname);
}

class MiddleNameEvent extends SignUpEvents {
  final String middleName;
  const MiddleNameEvent(this.middleName);
}

class LastNameEvent extends SignUpEvents {
  final String lastName;
  const LastNameEvent(this.lastName);
}

class EmailEvent extends SignUpEvents {
  final String email;
  const EmailEvent(this.email);
}

class PasswordEvent extends SignUpEvents {
  final String password;
  const PasswordEvent(this.password);
}

class RepasswordEvent extends SignUpEvents {
  final String repassword;
  const RepasswordEvent(this.repassword);
}

class GenderEvent extends SignUpEvents {
  final String gender;
  GenderEvent(this.gender);
  // @override
  // List<Object> get props => [gender];
}

class PhoneNoChanged extends SignUpEvents {
  final PhoneNumber phoneNumber;
  const PhoneNoChanged(this.phoneNumber);

  List<Object> get props => [phoneNumber];
}

class PhoneNoValidationChanged extends SignUpEvents {
  final bool isValid;
  const PhoneNoValidationChanged(this.isValid);

  List<Object> get props => [isValid];
}

class DateOfBirthEvent extends SignUpEvents {
  final String? dateOfBirth;
  const DateOfBirthEvent(this.dateOfBirth);
}

class PickImage extends SignUpEvents {}

class SignUpLoadingEvent extends SignUpEvents {}

class SignUpSuccessEvent extends SignUpEvents {}

class SignUpFailureEvent extends SignUpEvents {
  final String error;
  const SignUpFailureEvent({required this.error});
}
