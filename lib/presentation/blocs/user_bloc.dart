import 'package:bloc/bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meta/meta.dart';
import 'package:testxxxx/core/network_services/error_handler.dart';
import 'package:testxxxx/domain/entities/user_entity.dart';
import 'package:testxxxx/domain/usecases/user_usecase.dart';

part 'user_event.dart';
part 'user_state.dart';

@singleton
class UserBloc extends Bloc<UserEvent, UserState> {

  UserBloc({required UserUseCase useCase}) : super(UserInitialState()) {
    on<AddNewUserEvent>((event, emit) async {
      emit(UserLoadingState());
      final result = await useCase.addNewUser(event.userEntity);
      result.fold((l) => emit(UserFailureState(failure: l)), (r) => emit(UserSuccessState.fromUser(r)));
    });
    on<GetUserListEvent>((event, emit) async {
      emit(UserLoadingState());
      final result = await useCase.getUserList();
      result.fold((l) => emit(UserFailureState(failure: l)), (r) => emit(UserSuccessState.fromUserList(r)));
    });
    on<UpdateUserEvent>((event, emit) async {
      emit(UserLoadingState());
      final result = await useCase.updateUser(event.userEntity);
      result.fold((l) => emit(UserFailureState(failure: l)), (r) => emit(UserSuccessState.fromUser(r)));
    });
    on<DeleteUserEvent>((event, emit) async {
      emit(UserLoadingState());
      final result = await useCase.deleteUser(event.id);
      result.fold((l) => emit(UserFailureState(failure: l)), (r) => emit(UserSuccessState.fromMessage("Delete user successfully.")));
    });
  }
}
