import 'dart:convert';

import 'package:testxxxx/utils/shared_preferences.dart';

import '../domain/entities/language_entity.dart';
import 'constants.dart';

Future<LanguageEntity> getLanguageFromSharedPreferences() async {
  final jsonString = await SharedPreferencesHelper().loadData(keyLanguage);
  return jsonString != null
      ? LanguageEntity.fromJson(json.decode(jsonString ?? ''))
      : LanguageEntity.getLanguageList().first;
}