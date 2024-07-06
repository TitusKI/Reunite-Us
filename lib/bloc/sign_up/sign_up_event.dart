part of "sign_up_bloc.dart";

abstract class SignUpEvents extends SharedEvent {
  const SignUpEvents();
}

class GenderEvent extends SignUpEvents {
  final String gender;
  const GenderEvent(this.gender);
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

class SignUpLoadingEvent extends SignUpEvents {}

class SignUpSuccessEvent extends SignUpEvents {}

class SignUpFailureEvent extends SignUpEvents {
  final String error;
  const SignUpFailureEvent({required this.error});
}

class SignUpReset extends SignUpEvents {}
