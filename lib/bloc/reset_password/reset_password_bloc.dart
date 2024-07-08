import 'package:afalagi/bloc/shared_event.dart';
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
  }
  void _passwordEvent(PasswordEvent event, Emitter<ResetPasswordState> emit) {
    emit(
      state.copyWith(password: event.password, repassword: event.repassword),
    );
  }
}
