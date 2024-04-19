import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:json_annotation/json_annotation.dart';
import 'package:testxxxx/utils/shared_preferences.dart';

import '../../generated/locale_keys.g.dart';
import '../../utils/constants.dart';

part 'language_entity.g.dart';

@JsonSerializable()
class LanguageEntity {
  final int id;
  final String language;
  final String flag;

  LanguageEntity(
      {required this.id, required this.language, required this.flag});

  factory LanguageEntity.fromJson(Map<String, dynamic> json) => _$LanguageEntityFromJson(json);
  Map<String, dynamic> toJson() => _$LanguageEntityToJson(this);

  static List<LanguageEntity> getLanguageList() {
    return [
      LanguageEntity(
          id: 1,
          language: LocaleKeys.vietnamese.tr(),
          flag: 'assets/icons/ic_flag_vn.png'),
      LanguageEntity(
          id: 2,
          language: LocaleKeys.english.tr(),
          flag: 'assets/icons/ic_flag_vn.png')
    ];
  }
  static Future<int?> getPref() async {
    final jsonString = await SharedPreferencesHelper().loadData(keyLanguage);
    return jsonString != null ? LanguageEntity.fromJson(json.decode(jsonString)).id : null;
  }
}
