import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:testxxxx/core/network_services/api_service.dart';
import 'package:testxxxx/core/network_services/error_handler.dart';
import 'package:testxxxx/data/datasources/remote_datasources/user_remote_datasource.dart';
import 'package:testxxxx/data/models/user_model.dart';

import '../../../core/network_services/api_execution.dart';

@Injectable(as: UserRemoteDataSource)
class UserRemoteDatasourceImpl extends UserRemoteDataSource {

  final ApiExecution _apiExecution;

  UserRemoteDatasourceImpl(this._apiExecution);

  @override
  Future<Either<Failure, UserModel?>> addNewUser(UserModel userModel) async {
    final result = await _apiExecution.execute(client.addNewUser(userModel));
    return result.fold((l) => Left(l), (r) => Right(r.user));
  }

  @override
  Future<Either<Failure, dynamic>> deleteUser(String id) async {
    final result = await _apiExecution.execute(client.deleteUser(id));
    return result.fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, List<UserModel>>> getUserList() async {
    final result = await _apiExecution.execute(client.getUsers());
    return result.fold((l) => Left(l), (r) => Right(r.users ?? List.empty()));
  }

  @override
  Future<Either<Failure, UserModel?>> updateUser(UserModel userModel) async {
    final result = await _apiExecution.execute(client.updateUser(userModel));
    return result.fold((l) => Left(l), (r) => Right(r.user));
  }

}