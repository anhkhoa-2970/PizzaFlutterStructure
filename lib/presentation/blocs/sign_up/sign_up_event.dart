part of 'sign_up_bloc.dart';

abstract class SignUpEvent {}

class SignUpRequiredEvent extends SignUpEvent {
  final String name;
  final String email;
  final String password;
  final String phoneNumber;

  SignUpRequiredEvent({
    required this.name,
    required this.email,
    required this.password,
    required this.phoneNumber,
  });
}
