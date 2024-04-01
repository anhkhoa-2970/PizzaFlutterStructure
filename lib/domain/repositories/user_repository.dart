import 'package:dartz/dartz.dart';

import '../../core/network_services/error_handler.dart';
import '../entities/user_entity.dart';

abstract class UserRepository {
  Future<Either<Failure, List<UserEntity>>> getUserList();
  Future<Either<Failure, dynamic>> deleteUser(String id);
  Future<Either<Failure, UserEntity?>> addNewUser(UserEntity userEntity);
  Future<Either<Failure, UserEntity?>> updateUser(UserEntity userEntity);
}
