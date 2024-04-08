// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'my_user_entity.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MyUserEntity _$MyUserEntityFromJson(Map<String, dynamic> json) => MyUserEntity(
      userId: json['userId'] as String?,
      email: json['email'] as String?,
      password: json['password'] as String?,
      name: json['name'] as String?,
      hasActiveCart: json['hasActiveCart'] as bool?,
    );

Map<String, dynamic> _$MyUserEntityToJson(MyUserEntity instance) =>
    <String, dynamic>{
      'userId': instance.userId,
      'email': instance.email,
      'password': instance.password,
      'name': instance.name,
      'hasActiveCart': instance.hasActiveCart,
    };
