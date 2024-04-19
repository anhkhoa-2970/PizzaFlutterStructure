// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'language_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

LanguageEntity _$LanguageEntityFromJson(Map<String, dynamic> json) =>
    LanguageEntity(
      id: json['id'] as int,
      language: json['language'] as String,
      flag: json['flag'] as String,
    );

Map<String, dynamic> _$LanguageEntityToJson(LanguageEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'language': instance.language,
      'flag': instance.flag,
    };
