import 'package:afalagi/bloc/sign_up/sign_up_event.dart';
import 'package:afalagi/bloc/sign_up/sign_up_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SignUpBloc extends Bloc<SignUpEvents, SignUpStates> {
  SignUpBloc() : super(const SignUpStates()) {
    on<UserNameEvent>(_userNameEvent);
    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);
    on<RepasswordEvent>(_repasswordEvent);
    on<SignUpLoadingEvent>(_SignUpLoadingEvent);
    on<SignUpSuccessEvent>(_SignUpSuccessEvent);
    on<SignUpFailureEvent>(_SignUpFailureEvent);
  }
  Stream<SignUpStates> _SignUpLoadingEvent(
      SignUpLoadingEvent event, Emitter<SignUpStates> emit) async* {
    emit(const SignUpLoadingState());
    try {
      const CircularProgressIndicator();
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<SignUpStates> _SignUpSuccessEvent(
      SignUpSuccessEvent event, Emitter<SignUpStates> emit) async* {
    emit(const SignUpSuccessState());
    try {
      const CircularProgressIndicator();
    } catch (e) {
      print(e.toString());
    }
  }

  Stream<SignUpStates> _SignUpFailureEvent(
      SignUpFailureEvent event, Emitter<SignUpStates> emit) async* {
    emit(const SignUpFailurState("Error Loading"));
  }

  void _userNameEvent(UserNameEvent event, Emitter<SignUpStates> emit) {
    print(event.userName);
    emit(
      state.copyWith(userName: event.userName),
    );
  }

  void _emailEvent(EmailEvent event, Emitter<SignUpStates> emit) {
    print(event.email);

    emit(
      state.copyWith(email: event.email),
    );
  }

  void _passwordEvent(PasswordEvent event, Emitter<SignUpStates> emit) {
    print(event.password);

    emit(
      state.copyWith(password: event.password),
    );
  }

  void _repasswordEvent(RepasswordEvent event, Emitter<SignUpStates> emit) {
    print(event.repassword);

    emit(
      state.copyWith(repassword: event.repassword),
    );
  }
}
