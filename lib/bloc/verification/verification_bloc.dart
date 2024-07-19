import 'package:afalagi/services/api_services.dart';
import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'verification_event.dart';
part 'verification_state.dart';

class VerificationBloc extends Bloc<VerificationEvent, VerificationState> {
  final ApiServices _apiServices;
  VerificationBloc(this._apiServices) : super(VerificationInitial()) {
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
        await _apiServices.verifyCode(event.code, event.email);
        emit(VerificationSuccess());
      } catch (e) {
        if (e.toString().contains("401")) {
          // Token expired or invalid
          try {
            await _apiServices.refreshToken();
            // Retry verification after refreshing token
            await _apiServices.verifyCode(event.code, event.email);
            emit(VerificationSuccess());
          } catch (e) {
            emit(const VerificationFailure(
                "Token refresh failed. Please try again."));
          }
        } else {
          emit(VerificationFailure(e.toString()));
        }
      }
      // emit(VerificationSubmitted(event.code));
    });
    on<ResendCode>((event, emit) async {
      emit(VerificationLoading());
      try {
        await _apiServices.resendCode(event.email);
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
