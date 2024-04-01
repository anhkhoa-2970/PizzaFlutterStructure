part of 'user_bloc.dart';

@immutable
abstract class UserEvent {}
class AddNewUserEvent extends UserEvent {
  final UserEntity userEntity;
  AddNewUserEvent(this.userEntity);
}

class UpdateUserEvent extends UserEvent {
  final UserEntity userEntity;
  UpdateUserEvent(this.userEntity);
}

class DeleteUserEvent extends UserEvent {
  final String id;
  DeleteUserEvent(this.id);
}

class GetUserListEvent extends UserEvent {}