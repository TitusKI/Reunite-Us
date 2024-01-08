import 'package:afalagi/repository/user_repository.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  final UserRepository _repository;
  VerificationBloc(this._repository) : super(VerificationInitial()) {
    on<CodeChanged>((event, emit) {
      if (event.code.length == 6) {
        emit(VerificationCodeValid(event.code));
      } else {
        emit(VerificationCodeInvalid(event.code));
      }
    });
    on<SubmitCode>((event, emit) async {
      emit(VerificationLoading());
      try {
        _repository.verifyCode(code: event.code!, email: event.email!);
        print("Verification code : ${event.code}");
        print("Verification email : ${event.email}");

        emit(VerificationSuccess());
      } catch (e) {
        print(e.toString());
        // if (e.toString().contains("401")) {
        //   // Token expired or invalid
        //   try {
        //     await _repository.refreshToken();
        //     // Retry verification after refreshing token
        //     await _repository.verifyCode(
        //         code: event.code!, email: event.email!);
        //     emit(VerificationSuccess());
        //   } catch (e) {
        //     emit(const VerificationFailure(
        //         "Token refresh failed. Please try again."));
        //   }
        // } else {
        //   emit(VerificationFailure(e.toString()));
        // }
      }
      // emit(VerificationSubmitted(event.code));
    });
    // on<SubmitResetCode>((event, emit) async {
    //   emit(VerificationLoading());
    //   try {
    //     await _repository.forgotPassword(event.email!);
    //     emit(VerificationSuccess());
    //     print("Reset this ${event.email} ");
    //   } catch (e) {
    //     emit(VerificationFailure(e.toString()));
    //   }
    // });
    on<ResendCode>((event, emit) async {
      emit(VerificationLoading());
      try {
        await _repository.resendCode(event.email);
        emit(VerificationCodeResent());
      } catch (e) {
        emit(VerificationFailure(e.toString()));
      }
    });
    on<ResetCode>((event, emit) {
      emit(VerificationInitial());
    });
  }
}
