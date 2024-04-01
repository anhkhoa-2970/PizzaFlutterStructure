// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'api_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

APIResponse<T> _$APIResponseFromJson<T>(
  Map<String, dynamic> json,
  T Function(Object? json) fromJsonT,
) =>
    APIResponse<T>()
      ..status = json['status'] as bool
      ..message = json['message'] as String?
      ..data = fromJsonT(json['data']);

Map<String, dynamic> _$APIResponseToJson<T>(
  APIResponse<T> instance,
  Object? Function(T value) toJsonT,
) =>
    <String, dynamic>{
      'status': instance.status,
      'message': instance.message,
      'data': toJsonT(instance.data),
    };

ResponseGetUsers _$ResponseGetUsersFromJson(Map<String, dynamic> json) =>
    ResponseGetUsers()
      ..users = (json['users'] as List<dynamic>?)
          ?.map((e) => UserModel.fromJson(e as Map<String, dynamic>))
          .toList();

Map<String, dynamic> _$ResponseGetUsersToJson(ResponseGetUsers instance) =>
    <String, dynamic>{
      'users': instance.users,
    };

ResponseUser _$ResponseUserFromJson(Map<String, dynamic> json) => ResponseUser()
  ..user = json['user'] == null
      ? null
      : UserModel.fromJson(json['user'] as Map<String, dynamic>);

Map<String, dynamic> _$ResponseUserToJson(ResponseUser instance) =>
    <String, dynamic>{
      'user': instance.user,
    };
