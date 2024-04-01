
import 'package:json_annotation/json_annotation.dart';

part 'user_entity.g.dart';

@JsonSerializable()
class UserEntity {
  int? id;
  String? email;
  String? firstName;
  String? lastName;
  String? avatar;

  UserEntity({this.id, this.email, this.firstName, this.lastName, this.avatar});

  factory UserEntity.fromJson(Map<String, dynamic> json) => _$UserEntityFromJson(json);
  Map<String, dynamic> toJson()=> _$UserEntityToJson(this);
}
