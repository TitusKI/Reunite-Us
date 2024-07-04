import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc() : super(const SignInState()) {
// on<EmailEvent>((event, emit) {
//  emit(state.copyWith(email: event.email));
// });
// on<PasswordEvent>((event, emit) {
// //  emit(state.copyWith(password: event.password));
// });

// just to know where did the emit comes from
//They do the same as the above one
    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);
    on<TogglePasswordVisibility>(togglePasswordVisibility);
  }

  void _emailEvent(EmailEvent event, Emitter<SignInState> emit) {
    // print("My Email Is: ${event.email}");

    emit(state.copyWith(email: event.email));
  }

  void _passwordEvent(PasswordEvent event, Emitter<SignInState> emit) {
    // print("My Password is:${event.password}");
    emit(state.copyWith(password: event.password));
  }

  void togglePasswordVisibility(
      TogglePasswordVisibility event, Emitter<SignInState> emit) {
    emit(state.copyWith(
        obscurePassword: !state.obscurePassword,
        iconPassword: state.obscurePassword
            ? CupertinoIcons.eye_slash_fill
            : Icons.remove_red_eye_rounded));
  }
}
