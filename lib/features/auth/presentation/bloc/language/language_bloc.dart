import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'language_event.dart';
part 'language_state.dart';

class LanguageBloc extends Bloc<LanguageEvent, LanguageState> {
  LanguageBloc() : super(const LanguageState()) {
    on<LanguageEvent>((event, emit) {
      emit(
        state.copyWith(
          amharic: event.onAmharic,
          english: event.onEnglish,
        ),
      );
    });
  }
}
