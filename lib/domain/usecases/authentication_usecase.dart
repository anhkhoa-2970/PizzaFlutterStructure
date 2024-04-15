import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:testxxxx/domain/repositories/authenticaiton_repository.dart';

import '../../core/network_services/error_handler.dart';
import '../entities/my_user_entity.dart';

@singleton
class AuthenticationUseCase{
  final AuthenticationRepository _authenticationRepository;
  AuthenticationUseCase(this._authenticationRepository);

  Stream<Either<Failure,MyUserEntity>> get user => _authenticationRepository.user;

  Future<Either<Failure,MyUserEntity>> signUp(MyUserEntity myUser, String password) => _authenticationRepository.signUp(myUser, password);

  Future<Either<Failure,void>> setUserData(MyUserEntity myUser) => _authenticationRepository.setUserData(myUser);

  Future<Either<Failure,void>> signIn(String email, String password) => _authenticationRepository.signIn(email, password);

  Future<Either<Failure,void>> logout() => _authenticationRepository.logout();
}