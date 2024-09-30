import 'dart:async';
import 'package:afalagi/features/post/domain/entities/search_filter.dart';

import '../../../../core/constants/presentation_export.dart';
import '../../../../injection_container.dart';
import '../../data/services/local/search_cache.dart';
import '../../domain/usecases/get_filtered_post.dart';

class SearchCubit extends Cubit<GenericState> {
  final StreamController<String> _searchController = StreamController<String>();
  final Duration debounceDuration = const Duration(milliseconds: 500);
  Timer? _debounce;

  String? _ageRange;
  String? _nationality;
  String? _lastSeenLocation;
  String _searchText = '';

  SearchCubit() : super(const GenericState()) {
    _searchController.stream.listen((searchText) {
      _searchText = searchText;
      _debounceSearch(searchText);
    });
  }

  void search(String searchText) {
    _searchController.add(searchText);
  }

  void _debounceSearch(String searchText) {
    // Cancel any existing debounce timer
    if (_debounce?.isActive ?? false) _debounce!.cancel();

    // Start a new debounce timer
    _debounce = Timer(debounceDuration, () {
      if (searchText.isNotEmpty) {
        performSearch(searchText);
      } else {
        showRecentSearches();
      }
    });
  }

  void showRecentSearches() async {
    emit(state.copyWith(isLoading: false, isSuccess: false, data: null));
    final recentSearches = await sl<SearchCacheService>().getRecentSearches();
    emit(state.copyWith(isSuccess: true, data: recentSearches));
  }

  Future<void> performSearch(String searchText) async {
    emit(state.copyWith(isLoading: true, isSuccess: false));
    try {
      // Cache the search text only after the user has paused typing
      await sl<SearchCacheService>().addSearch(searchText);
      final results = await sl<GetFilteredPostUsecase>()
          .call(parms: _getSearchFilter(searchText));
      emit(state.copyWith(isLoading: false, isSuccess: true, data: results));
    } catch (e) {
      emit(state.copyWith(
          isLoading: false, isSuccess: false, failure: e.toString()));
    }
  }

  void applyFilters() {
    // Apply the current filters to the API call
    performSearch(_searchText);
  }

  void updateAgeRange(String? ageRange) {
    _ageRange = ageRange;
  }

  void updateNationality(String? nationality) {
    _nationality = nationality;
  }

  void updateLastSeenLocation(String? location) {
    _lastSeenLocation = location;
  }

  SearchFilterEntity _getSearchFilter(String name) {
    return SearchFilterEntity(
      name: name,
      ageRange: _ageRange,
      nationality: _nationality,
      lastSeenLocation: _lastSeenLocation,
    );
  }

  @override
  Future<void> close() {
    _debounce?.cancel();
    _searchController.close();
    return super.close();
  }
}
