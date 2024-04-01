import 'package:injectable/injectable.dart';
import 'package:testxxxx/data/mappers/mapper.dart';
import 'package:testxxxx/data/models/user_model.dart';
import 'package:testxxxx/domain/entities/user_entity.dart';

@singleton
class UserMapper extends Mapper<UserModel, UserEntity> {
  @override
  UserModel entityToModel(UserEntity entity) {
    return UserModel(
        id: entity.id,
        avatar: entity.avatar,
        email: entity.email,
        firstName: entity.firstName,
        lastName: entity.lastName);
  }

  @override
  UserEntity modelToEntity(UserModel model) {
    return UserEntity(
        lastName: model.lastName, firstName: model.firstName, email: model.email, avatar: model.avatar, id: model.id);
  }
}
