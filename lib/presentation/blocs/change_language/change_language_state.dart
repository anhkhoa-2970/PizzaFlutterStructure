part of 'change_language_bloc.dart';

abstract class ChangeLanguageState {}

class ChangeLanguageInitialState extends ChangeLanguageState {}
class ChangeNewLanguageState extends ChangeLanguageState {
  Locale locale;
  ChangeNewLanguageState(this.locale);
}
