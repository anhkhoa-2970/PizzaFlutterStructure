import 'package:injectable/injectable.dart';
import 'package:testxxxx/data/models/my_user_model.dart';
import 'package:testxxxx/domain/entities/my_user_entity.dart';

import 'mapper.dart';

@singleton
class MyUserMapper implements Mapper<MyUserModel, MyUserEntity>{
  @override
  MyUserModel entityToModel(MyUserEntity entity) {
    return MyUserModel(userId: entity.phoneNumber, email: entity.email, password: entity.password, name: entity.name, hasActiveCart: entity.hasActiveCart);
  }

  @override
  MyUserEntity modelToEntity(MyUserModel model) {
    return MyUserEntity(phoneNumber: model.userId, email: model.email, password: model.password, name: model.name, hasActiveCart: model.hasActiveCart);
  }
}