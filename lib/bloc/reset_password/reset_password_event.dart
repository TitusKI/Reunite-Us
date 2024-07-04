part of 'reset_password_bloc.dart';

sealed class ResetPasswordEvent extends Equatable {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class EmailEvent extends ResetPasswordEvent {
  final String? email;
  const EmailEvent({this.email});
}

class ResetEmail extends ResetPasswordEvent {}

class PasswordEvent extends ResetPasswordEvent {
  final String password;
  const PasswordEvent(this.password);
}

class RepasswordEvent extends ResetPasswordEvent {
  final String repassword;
  const RepasswordEvent(this.repassword);
}
