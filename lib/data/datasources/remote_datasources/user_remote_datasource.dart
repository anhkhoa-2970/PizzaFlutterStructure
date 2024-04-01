
import 'package:dartz/dartz.dart';
import 'package:testxxxx/core/network_services/error_handler.dart';
import 'package:testxxxx/data/models/user_model.dart';

abstract class UserRemoteDataSource {
  Future<Either<Failure, List<UserModel>>> getUserList();
  Future<Either<Failure, dynamic>> deleteUser(String id);
  Future<Either<Failure, UserModel?>> addNewUser(UserModel userModel);
  Future<Either<Failure, UserModel?>> updateUser(UserModel userModel);
}