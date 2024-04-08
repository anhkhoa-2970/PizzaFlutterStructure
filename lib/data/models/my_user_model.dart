import 'package:json_annotation/json_annotation.dart';
part 'my_user_model.g.dart';
@JsonSerializable()
class MyUserModel {
  String? userId;
  String? email;
  String? password;
  String? name;
  bool? hasActiveCart;

  MyUserModel(
      { this.userId,
       this.email,
       this.password,
       this.name,
       this.hasActiveCart});

  factory MyUserModel.fromJson(Map<String, dynamic> json) => _$MyUserModelFromJson(json);
  Map<String, dynamic> toJson() => _$MyUserModelToJson(this);
}
