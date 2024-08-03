import 'package:afalagi/domain/usecases/auth/sign_out.dart';
import 'package:afalagi/injection_container.dart';
import 'package:afalagi/presentation/bloc/generic_state.dart';
import 'package:bloc/bloc.dart';

class SignOutCubit extends Cubit<GenericState> {
  SignOutCubit() : super(const GenericState());
  Future<void> signOut() async {
    emit(state.copyWith(isLoading: true));
    try {
      await sl<SignOutUsecase>().call();
      // sl<AuthRepository>().signOut();
      emit(state.copyWith(isSuccess: true, isLoading: false, failure: null));
    } catch (e) {
      emit(state.copyWith(
        isLoading: false,
        isSuccess: false,
        failure: e.toString(),
      ));
    }
  }
}
