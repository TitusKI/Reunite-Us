part of 'search_bloc.dart';

abstract class SearchState extends Equatable {
  const SearchState();

  @override
  List<Object> get props => [];
}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<String> recentSearches;
  final bool isSearching;
  final bool showRecentSearches;
  const SearchLoaded(this.recentSearches,
      {this.isSearching = false, this.showRecentSearches = false});

  @override
  List<Object> get props => [recentSearches, isSearching, showRecentSearches];
}
