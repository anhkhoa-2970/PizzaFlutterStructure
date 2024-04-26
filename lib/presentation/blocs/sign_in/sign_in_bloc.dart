import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:testxxxx/domain/usecases/authentication_usecase.dart';


part 'sign_in_event.dart';
part 'sign_in_state.dart';
@singleton
class SignInBloc extends Bloc<SignInEvent, SignInState> {
  SignInBloc({required AuthenticationUseCase useCase}) : super(SignInInitial()) {
    on<SignInRequiredEvent>((event, emit) async {
      emit(SignInProcess());
      try {
        final result = await useCase.signIn(event.email, event.password);
        result.fold((fail) => emit(SignInFailure(fail.message)), (r) => emit(SignInSuccess()));
      } catch (e) {
        emit(const SignInFailure('Unknown error...'));
      }
    });

    on<SignOutRequired>((event, emit) async {
      await useCase.logout();
    });
  }
}
