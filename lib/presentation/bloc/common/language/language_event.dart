part of 'language_bloc.dart';

class LanguageEvent extends Equatable {
  final String onEnglish;
  final String onAmharic;

  const LanguageEvent({this.onAmharic = "", this.onEnglish = ""});

  @override
  List<Object> get props => [onAmharic, onEnglish];
}
