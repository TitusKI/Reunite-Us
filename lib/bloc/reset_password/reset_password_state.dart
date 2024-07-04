part of 'reset_password_bloc.dart';

class ResetPasswordState {
  final String email;
  final String password;
  final String repassword;
  const ResetPasswordState({
    this.email = "",
    this.password = "",
    this.repassword = "",
  });
  ResetPasswordState copyWith({
    String? email,
    String? password,
    String? repassword,
  }) {
    return ResetPasswordState(
      email: email ?? this.email,
      password: password ?? this.password,
      repassword: repassword ?? this.repassword,
    );
  }
}

class ResetToInitial extends ResetPasswordState {}
