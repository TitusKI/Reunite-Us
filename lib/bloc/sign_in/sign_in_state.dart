part of "sign_in_bloc.dart";

class SignInState {
  final String email;
  final String password;
  final bool obscurePassword;
  final IconData iconPassword;

  const SignInState({
    this.email = "",
    this.password = "",
    this.obscurePassword = true,
    this.iconPassword = Icons.remove_red_eye_rounded,
  });
  SignInState copyWith({
    String? email,
    String? password,
    bool? obscurePassword,
    IconData? iconPassword,
  }) {
    return SignInState(
      email: email ?? this.email,
      password: password ?? this.password,
      obscurePassword: obscurePassword ?? this.obscurePassword,
      iconPassword: iconPassword ?? this.iconPassword,
    );
  }
}
