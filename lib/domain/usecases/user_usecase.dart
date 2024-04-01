import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:testxxxx/domain/repositories/user_repository.dart';

import '../../core/network_services/error_handler.dart';
import '../entities/user_entity.dart';

@singleton
class UserUseCase {
  final UserRepository _repository;

  UserUseCase(this._repository);

  Future<Either<Failure, List<UserEntity>>> getUserList() => _repository.getUserList();
  Future<Either<Failure, dynamic>> deleteUser(String id) => _repository.deleteUser(id);
  Future<Either<Failure, UserEntity?>> addNewUser(UserEntity userEntity) => _repository.addNewUser(userEntity);
  Future<Either<Failure, UserEntity?>> updateUser(UserEntity userEntity) => _repository.updateUser(userEntity);
}
