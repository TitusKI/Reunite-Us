import 'package:afalagi/domain/repository/auth/auth_repository.dart';
import 'package:afalagi/domain/usecases/auth/forgot_password.dart';
import 'package:afalagi/injection_container.dart';
import 'package:afalagi/presentation/bloc/shared_event.dart';
import 'package:bloc/bloc.dart';
part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<SharedEvent, ResetPasswordState> {
  ResetPasswordBloc() : super(const ResetPasswordState()) {
    on<EmailEvent>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<ResetEmail>((event, emit) {
      emit(ResetToInitial());
    });
    on<PasswordEvent>(_passwordEvent);
    on<SubmitResetCode>(_submitResetCode);
    // on<SubmitNewPassword>(_submitNewPassword);
  }
  // void _submitNewPassword(
  //     SubmitNewPassword event, Emitter<ResetPasswordState> emit) async {
  //   emit(state.copyWith(isResetLoading: true));
  //   try {
  //     sl<AuthRepository>()
  //         .resetPassword(event.newPassword!, event.passwordConfirm!);
  //     emit(state.copyWith(
  //       isResetLoading: false,
  //       isResetSuccess: true,
  //       resetFailure: "",
  //     ));
  //   } catch (e) {
  //     emit(state.copyWith(
  //         isResetLoading: false,
  //         isResetSuccess: false,
  //         resetFailure: e.toString()));
  //   }
  // }

  Future<void> _submitResetCode(
      SubmitResetCode event, Emitter<ResetPasswordState> emit) async {
    emit(state.copyWith(isResetLoading: true));
    try {
      await sl<ForgotPasswordUsecase>().call(parms: event.email);

      sl<AuthRepository>().forgotPassword(event.email!);
      emit(state.copyWith(
          isResetSuccess: true, isResetLoading: false, resetFailure: ''));
    } catch (e) {
      emit(state.copyWith(
          isResetLoading: false,
          isResetSuccess: false,
          resetFailure: e.toString()));
    }
  }

  void _passwordEvent(PasswordEvent event, Emitter<ResetPasswordState> emit) {
    emit(
      state.copyWith(password: event.password, repassword: event.repassword),
    );
  }
}
