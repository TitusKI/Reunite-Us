import 'package:afalagi/bloc/generic_state.dart';
import 'package:afalagi/repository/user_repository.dart';
import 'package:bloc/bloc.dart';

class SignOutCubit extends Cubit<GenericState> {
  final UserRepository _repository;
  SignOutCubit(this._repository) : super(const GenericState());
  Future<void> signOut() async {
    emit(state.copyWith(isLoading: true));
    try {
      _repository.signOut();
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
