// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserEntity _$UserEntityFromJson(Map<String, dynamic> json) => UserEntity(
      id: json['id'] as int?,
      email: json['email'] as String?,
      firstName: json['firstName'] as String?,
      lastName: json['lastName'] as String?,
      avatar: json['avatar'] as String?,
    );

Map<String, dynamic> _$UserEntityToJson(UserEntity instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'firstName': instance.firstName,
      'lastName': instance.lastName,
      'avatar': instance.avatar,
    };
