part of 'reset_password_bloc.dart';

sealed class ResetPasswordEvent extends SharedEvent {
  const ResetPasswordEvent();

  @override
  List<Object> get props => [];
}

class ResetEmail extends ResetPasswordEvent {}
