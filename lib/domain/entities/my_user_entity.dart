import 'package:json_annotation/json_annotation.dart';
part 'my_user_entity.g.dart';
@JsonSerializable()
class MyUserEntity {
  String? phoneNumber;
  String? email;
  String? password;
  String? name;
  bool? hasActiveCart;

  MyUserEntity(
      {this.phoneNumber, this.email, this.password, this.name, this.hasActiveCart});


  factory MyUserEntity.fromJson(Map<String, dynamic> json) =>
      _$MyUserEntityFromJson(json);
  Map<String, dynamic> toJson() => _$MyUserEntityToJson(this);

  static final empty = MyUserEntity(
    phoneNumber: '',
    email: '',
    name: '',
    hasActiveCart: false,
  );
}
