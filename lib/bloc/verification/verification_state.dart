part of 'verification_bloc.dart';

sealed class VerificationState extends Equatable {
  const VerificationState();

  @override
  List<Object> get props => [];
}

final class VerificationInitial extends VerificationState {}

class VerificationCodeInvalid extends VerificationState {
  final String code;

  const VerificationCodeInvalid(this.code);

  @override
  List<Object> get props => [code];
}

class VerificationCodeValid extends VerificationState {
  final String code;

  const VerificationCodeValid(this.code);

  @override
  List<Object> get props => [code];
}

class VerificationSubmitted extends VerificationState {
  final String code;
  const VerificationSubmitted(this.code);
  @override
  List<Object> get props => [code];
}

class VerificationReset extends VerificationState {}
