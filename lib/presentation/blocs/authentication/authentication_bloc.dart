import 'dart:async';
import 'dart:js_interop';

import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testxxxx/domain/entities/my_user_entity.dart';
import 'package:testxxxx/domain/usecases/authentication_usecase.dart';

import '../../../core/network_services/error_handler.dart';

part 'authentication_event.dart';

part 'authentication_state.dart';

class AuthenticationBloc
    extends Bloc<AuthenticationEvent, AuthenticationState> {
  late final StreamSubscription<Either<Failure, MyUserEntity>>
      _userSubscription;

  AuthenticationBloc({required AuthenticationUseCase useCase})
      : super(const AuthenticationState.unknown()) {
    _userSubscription = useCase.user.listen((event) {
      event.fold(
        (fail) => {add(const AuthenticationUserChanged(null))},
        (myUser) => {add(AuthenticationUserChanged(myUser))},
      );
    });

    on<AuthenticationUserChanged>((event, emit) {
      if(event.myUser != null && event.myUser != MyUserEntity.empty) {
        emit(AuthenticationState.authenticated(event.myUser!));
      } else {
        emit(const AuthenticationState.unauthenticated());
      }
    });
  }

  @override
  Future<void> close() {
    _userSubscription.cancel();
    return super.close();
  }
}
