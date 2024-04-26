import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:testxxxx/domain/entities/my_user_entity.dart';
import 'package:testxxxx/domain/usecases/authentication_usecase.dart';

part 'sign_up_event.dart';
part 'sign_up_state.dart';
@singleton
class SignUpBloc extends Bloc<SignUpEvent, SignUpState> {
  SignUpBloc({required AuthenticationUseCase useCase}) : super(SignUpInitial()) {
    on<SignUpRequiredEvent>((event, emit)async {
      emit(SignUpProcess());
      
      try {
        final result = await useCase.signUp(MyUserEntity(name: event.name, email: event.email,password: event.password, phoneNumber: event.phoneNumber), event.password);
        result.fold((fail) => emit(SignUpFailure(fail.message)), (success) => emit(SignUpSuccess()));
      } catch (e){
        emit(const SignUpFailure('Unknown error...'));
      }
    });
  }
}
