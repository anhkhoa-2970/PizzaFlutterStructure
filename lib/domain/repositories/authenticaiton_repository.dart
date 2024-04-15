import 'package:dartz/dartz.dart';
import 'package:testxxxx/core/network_services/error_handler.dart';
import 'package:testxxxx/domain/entities/my_user_entity.dart';

abstract class AuthenticationRepository{
  Stream<Either<Failure,MyUserEntity>> get user;

  Future<Either<Failure,MyUserEntity>> signUp(MyUserEntity myUser, String password);

  Future<Either<Failure,void>> setUserData(MyUserEntity myUser);

  Future<Either<Failure,void>> signIn(String email, String password);

  Future<Either<Failure,void>> logout();
}