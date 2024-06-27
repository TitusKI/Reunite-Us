abstract class SignUpEvents {
  const SignUpEvents();
}

class UserNameEvent extends SignUpEvents {
  final String userName;
  const UserNameEvent(this.userName);
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

class SignUpLoadingEvent extends SignUpEvents {}

class SignUpSuccessEvent extends SignUpEvents {}

class SignUpFailureEvent extends SignUpEvents {
  final String error;
  const SignUpFailureEvent({required this.error});
}
