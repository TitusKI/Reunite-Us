part of 'verification_bloc.dart';

sealed class VerificationEvent extends Equatable {
  const VerificationEvent();

  @override
  List<Object> get props => [];
}

class CodeChanged extends VerificationEvent {
  final String code;
  const CodeChanged(this.code);
  @override
  List<Object> get props => [code];
}

class SubmitCode extends VerificationEvent {
  final String code;
  const SubmitCode(this.code);
  @override
  List<Object> get props => [code];
}

class ResetCode extends VerificationEvent {}
