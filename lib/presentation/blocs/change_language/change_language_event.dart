part of 'change_language_bloc.dart';

@immutable

class ChangeLanguageEvent {
  final Locale locale;
  const ChangeLanguageEvent(this.locale);
}
