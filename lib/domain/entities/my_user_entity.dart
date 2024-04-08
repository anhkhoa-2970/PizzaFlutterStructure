import 'package:json_annotation/json_annotation.dart';
part 'my_user_entity.g.dart';
@JsonSerializable()
class MyUserEntity {
  String? userId;
  String? email;
  String? password;
  String? name;
  bool? hasActiveCart;

  MyUserEntity(
      {this.userId, this.email, this.password, this.name, this.hasActiveCart});


  factory MyUserEntity.fromJson(Map<String, dynamic> json) =>
      _$MyUserEntityFromJson(json);
  Map<String, dynamic> toJson() => _$MyUserEntityToJson(this);
}
