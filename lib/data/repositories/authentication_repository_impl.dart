import 'package:dartz/dartz.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:testxxxx/core/network_services/error_handler.dart';
import 'package:testxxxx/domain/entities/my_user_entity.dart';
import 'package:testxxxx/domain/repositories/authenticaiton_repository.dart';

class AuthenticationImpl implements AuthenticationRepository{
  // final FirebaseAuth _firebaseAuth;
  // final userCollection = FirebaseF
  @override
  Future<Either<Failure, void>> logout() {
    // TODO: implement logout
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> setUserData(MyUserEntity myUser) {
    // TODO: implement setUserData
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, void>> signIn(String email, String password) {
    // TODO: implement signIn
    throw UnimplementedError();
  }

  @override
  Future<Either<Failure, MyUserEntity>> signUp(MyUserEntity myUser, String password) {
    // TODO: implement signUp
    throw UnimplementedError();
  }

  @override
  // TODO: implement user
  Future<Either<Failure, MyUserEntity>> get user => throw UnimplementedError();
  
  
}