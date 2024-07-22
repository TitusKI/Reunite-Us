import 'package:afalagi/bloc/shared_event.dart';
import 'package:afalagi/routes/export.dart';
part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SharedEvent, SignInState> {
  SignInBloc() : super(const SignInState()) {
    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);
    on<SignInReset>(_resetToInitial);
    // on<TogglePasswordVisibility>(togglePasswordVisibility);
  }
  void _resetToInitial(SignInReset event, Emitter<SignInState> emit) {
    emit(SignInState.initial());
  }

  void _emailEvent(EmailEvent event, Emitter<SignInState> emit) {
    emit(state.copyWith(email: event.email));
  }

  void _passwordEvent(PasswordEvent event, Emitter<SignInState> emit) {
    // print("My Password is:${event.password}");
    emit(state.copyWith(password: event.password));
  }

  // void togglePasswordVisibility(
  //     TogglePasswordVisibility event, Emitter<SignInState> emit) {
  //   emit(state.copyWith(
  //       obscurePassword: !state.obscurePassword,
  //       iconPassword: state.obscurePassword
  //           ? CupertinoIcons.eye_slash_fill
  //           : Icons.remove_red_eye_rounded));
  // }
}
