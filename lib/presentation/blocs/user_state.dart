part of 'user_bloc.dart';

abstract class UserState {}

class UserInitialState extends UserState {}
class UserLoadingState extends UserState {}
class UserSuccessState extends UserState {
  UserEntity? userEntity;
  List<UserEntity>? users;
  String? message;

  UserSuccessState.fromUserList(this.users);
  UserSuccessState.fromUser(this.userEntity);
  UserSuccessState.fromMessage(this.message);
  UserSuccessState();
}
class UserFailureState extends UserState {
  Failure failure;
  UserFailureState({required this.failure});
}