import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:testxxxx/core/network_services/error_handler.dart';
import 'package:testxxxx/data/mappers/user_mapper.dart';
import 'package:testxxxx/domain/entities/user_entity.dart';
import 'package:testxxxx/domain/repositories/user_repository.dart';

import '../datasources/remote_datasources/user_remote_datasource.dart';

@Injectable(as: UserRepository)
class UserRepositoryImpl extends UserRepository {

  final UserRemoteDataSource _remoteDataSource;
  final UserMapper _mapper;

  UserRepositoryImpl(this._remoteDataSource, this._mapper);

  @override
  Future<Either<Failure, UserEntity?>> addNewUser(UserEntity userEntity) async {
    return (await _remoteDataSource.addNewUser(_mapper.entityToModel(userEntity)))
        .fold((l) => Left(l), (r) => Right(r != null ? _mapper.modelToEntity(r) : null));
  }

  @override
  Future<Either<Failure, dynamic>> deleteUser(String id) async {
    return (await _remoteDataSource.deleteUser(id)).fold((l) => Left(l), (r) => Right(r));
  }

  @override
  Future<Either<Failure, List<UserEntity>>> getUserList() async {
    return (await _remoteDataSource.getUserList()).fold((l) => Left(l), (r) => Right(r.map((e) => _mapper.modelToEntity(e)).toList()));
  }

  @override
  Future<Either<Failure, UserEntity?>> updateUser(UserEntity userEntity) async {
    return (await _remoteDataSource.updateUser(_mapper.entityToModel(userEntity)))
        .fold((l) => Left(l), (r) => Right(r != null ? _mapper.modelToEntity(r) : null));
  }

}