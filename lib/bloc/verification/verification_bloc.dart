import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  VerificationBloc() : super(VerificationInitial()) {
    on<CodeChanged>((event, emit) {
      if (event.code.length == 6) {
        emit(VerificationCodeValid(event.code));
      } else {
        emit(VerificationCodeInvalid(event.code));
      }
    });
    on<SubmitCode>((event, emit) {
      emit(VerificationSubmitted(event.code));
    });
    on<ResetCode>((event, emit) {
      emit(VerificationReset());
      emit(VerificationInitial());
    });
  }
}
