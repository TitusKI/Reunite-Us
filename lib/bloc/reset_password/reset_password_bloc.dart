import 'package:afalagi/bloc/shared_event.dart';
import 'package:afalagi/repository/user_repository.dart';
import 'package:bloc/bloc.dart';
part 'reset_password_event.dart';
part 'reset_password_state.dart';

class ResetPasswordBloc extends Bloc<SharedEvent, ResetPasswordState> {
  final UserRepository _repository;
  ResetPasswordBloc(this._repository) : super(const ResetPasswordState()) {
    on<EmailEvent>((event, emit) {
      emit(state.copyWith(email: event.email));
    });
    on<ResetEmail>((event, emit) {
      emit(ResetToInitial());
    });
    on<PasswordEvent>(_passwordEvent);
    on<SubmitResetCode>(_submitResetCode);
    on<SubmitNewPassword>(_submitNewPassword);
  }
  void _submitNewPassword(
      SubmitNewPassword event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(isResetLoading: true));
    try {
      _repository.resetPassword(event.newPassword!, event.passwordConfirm!);
      emit(state.copyWith(
        isResetLoading: false,
        isResetSuccess: true,
        resetFailure: "",
      ));
    } catch (e) {
      emit(state.copyWith(
          isResetLoading: false,
          isResetSuccess: false,
          resetFailure: e.toString()));
    }
  }

  void _submitResetCode(
      SubmitResetCode event, Emitter<ResetPasswordState> emit) {
    emit(state.copyWith(isResetLoading: true));
    try {
      _repository.forgotPassword(event.email!);
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
