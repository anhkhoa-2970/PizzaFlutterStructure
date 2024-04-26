import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';

part 'change_language_event.dart';
part 'change_language_state.dart';

@singleton
class ChangeLanguageBloc extends Bloc<ChangeLanguageEvent, ChangeLanguageState> {
  ChangeLanguageBloc() : super(ChangeLanguageInitialState()) {
    on<ChangeLanguageEvent>((event, emit) {
      emit(ChangeNewLanguageState(event.locale));
    });
  }
}
