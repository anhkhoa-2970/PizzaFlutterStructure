import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testxxxx/config/app_routes.dart';
import 'package:testxxxx/config/injection.dart';
import 'package:testxxxx/domain/entities/user_entity.dart';
import 'package:testxxxx/generated/locale_keys.g.dart';
import 'package:testxxxx/main.dart';
import 'package:testxxxx/presentation/blocs/user_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class UserPage extends StatefulWidget {
  const UserPage({super.key});

  @override
  State<StatefulWidget> createState() => _UserPageState();
}

class _UserPageState extends State<UserPage> {

  List<UserEntity> _users = List.empty();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.blue,
          title: Text(
            LocaleKeys.name.tr(),
            style: const TextStyle(color: Colors.white),
          ),
        ),
        body: BlocBuilder<UserBloc, UserState>(
          builder: (context, state) {
            return Container(
              padding: const EdgeInsets.all(20),
              width: double.infinity,
              height: double.infinity,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  OutlinedButton(
                      onPressed: () {
                        context.go('/userHome/userList');
                      },
                      child: const Text('go to list user')),
                  const SizedBox(height: 10),
                  OutlinedButton(
                      onPressed: () {
                        if (_users.isNotEmpty) {
                          context.pushNamed(AppRoutes.userList.name, extra: _users);
                        } else {
                          getIt<UserBloc>().add(GetUserListEvent());
                        }
                      },
                      child: Text(LocaleKeys.button1.tr())),
                  const SizedBox(height: 10),
                  OutlinedButton(
                      onPressed: () {
                        getIt<UserBloc>().add(AddNewUserEvent(UserEntity()));
                      },
                      child: Text(LocaleKeys.button2.tr())),
                  const SizedBox(height: 10),
                  OutlinedButton(
                      onPressed: () {
                        getIt<UserBloc>().add(UpdateUserEvent(UserEntity()));
                      },
                      child: Text(LocaleKeys.button3.tr())),
                  const SizedBox(height: 10),
                  OutlinedButton(
                      onPressed: () {
                        getIt<UserBloc>().add(DeleteUserEvent("1"));
                      },
                      child: Text(LocaleKeys.button4.tr())),
                  Expanded(
                    child: Container(
                      alignment: Alignment.center,
                      child: Stack(
                        alignment: Alignment.center,
                        children: [
                          buildResultWidget(state),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        ));
  }

  Widget buildResultWidget(UserState state) {
    var text = "";
    if (state is UserSuccessState) {
      if (state.userEntity != null) {
        text = state.userEntity?.toJson().toString() ?? "";
      } else if (state.users != null) {
        _users = state.users ?? List.empty();
        text = state.users?.map((e) => e.toJson()).toString() ?? "";
      } else {
        text = state.message ?? "";
      }
    }
    switch (state.runtimeType) {
      case UserLoadingState:
        return const CircularProgressIndicator();
      case UserSuccessState:
        return Text(text, style: const TextStyle(color: Colors.black));
      case UserFailureState:
        return Text((state as UserFailureState).failure.message, style: const TextStyle(color: Colors.black));
      default:
        return Container();
    }
  }
}
