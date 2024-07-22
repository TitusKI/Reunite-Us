part of "sign_in_bloc.dart";

abstract class SignInEvent extends SharedEvent {
  const SignInEvent();
}

class SignInReset extends SignInEvent {}
