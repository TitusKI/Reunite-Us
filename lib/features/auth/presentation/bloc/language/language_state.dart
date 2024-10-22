part of 'language_bloc.dart';

class LanguageState extends Equatable {
  final String english;
  final String amharic;

  const LanguageState({
    this.english = '',
    this.amharic = '',
  });
  LanguageState copyWith({String? english, String? amharic}) {
    return LanguageState(
      english: english ?? this.english,
      amharic: amharic ?? this.amharic,
    );
  }

  @override
  List<Object> get props => [english, amharic];
}
