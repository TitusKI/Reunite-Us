import 'package:afalagi/bloc/shared_event.dart';
import 'package:afalagi/repository/user_repository.dart';
import 'package:afalagi/routes/export.dart';
part 'sign_in_event.dart';
part 'sign_in_state.dart';

class SignInBloc extends Bloc<SharedEvent, SignInState> {
  final UserRepository _repository;
  SignInBloc(this._repository) : super(const SignInState()) {
    on<EmailEvent>(_emailEvent);
    on<PasswordEvent>(_passwordEvent);
    on<SignInReset>(_resetToInitial);
    on<SignInSubmitEvent>(_signInSubmitEvent);
    on<GoogleSignInEvent>(_googleSignInEvent);
    // on<TogglePasswordVisibility>(togglePasswordVisibility);
  }
  Future<void> _signInSubmitEvent(
      SignInSubmitEvent event, Emitter<SignInState> emit) async {
    emit(state.copyWith(isSignInLoading: true));
    try {
      await _repository.signin(event.email, event.password);
      emit(state.copyWith(
        isSignInLoading: false,
        signInSuccess: true,
        signInFailure: "",
      ));
    } catch (e) {
      emit(state.copyWith(
          isSignInLoading: false,
          signInFailure: e.toString(),
          signInSuccess: false));
    }
  }

  Future<void> _googleSignInEvent(
      GoogleSignInEvent event, Emitter<SignInState> emit) async {
    emit(state.copyWith(isGoogleSignInLoading: true));
    try {
      await _repository.signInWithGoogle();
      emit(state.copyWith(
        isGoogleSignInLoading: false,
        isGoogleSignInSuccess: true,
        googleSignInFailure: "",
      ));
    } catch (e) {
      emit(state.copyWith(
          isGoogleSignInLoading: false,
          googleSignInFailure: e.toString(),
          isGoogleSignInSuccess: false));
    }
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
