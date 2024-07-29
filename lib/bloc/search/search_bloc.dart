import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<SearchTextChanged>((event, emit) {
      if (event.searchText.isEmpty) {
        emit(SearchLoaded(_recentSearches,
            isSearching: true, showRecentSearches: false));
      } else {
        emit(SearchLoaded(_recentSearches,
            isSearching: true, showRecentSearches: false));
      }
    });

    on<SearchFieldFocused>((event, emit) {
      emit(SearchLoaded(_recentSearches,
          isSearching: true, showRecentSearches: true));
    });
  }

  final List<String> _recentSearches = [
    'John Doe',
    'Jane Smith',
    'Alex Johnson'
  ];
}
