import 'package:json_annotation/json_annotation.dart';

import '../../data/models/user_model.dart';

part 'api_response.g.dart';

@JsonSerializable(explicitToJson: true, genericArgumentFactories: true)
class APIResponse<T> {
  late bool status;
  late String? message;
  late T data;

  APIResponse();

  bool isSuccess() => status;

  factory APIResponse.fromJson(Map<String, dynamic> json, T Function(Object? json) fromJsonT) =>
      _$APIResponseFromJson(json, fromJsonT);

  Map<String, dynamic> toJson(Object? Function(T value) toJsonT) => _$APIResponseToJson(this, toJsonT);
}

@JsonSerializable()
class ResponseGetUsers {
  List<UserModel>? users;

  ResponseGetUsers();

  factory ResponseGetUsers.fromJson(Map<String, dynamic> json) => _$ResponseGetUsersFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseGetUsersToJson(this);
}


@JsonSerializable()
class ResponseUser {
  UserModel? user;
  ResponseUser();

  factory ResponseUser.fromJson(Map<String, dynamic> json) => _$ResponseUserFromJson(json);

  Map<String, dynamic> toJson() => _$ResponseUserToJson(this);
}
