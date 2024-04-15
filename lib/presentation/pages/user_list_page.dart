
import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testxxxx/config/app_router.dart';
import 'package:testxxxx/domain/entities/user_entity.dart';
import 'package:testxxxx/generated/locale_keys.g.dart';

import '../../config/app_routes.dart';
import '../../utils/constants.dart';
import '../../utils/shared_preferences.dart';

class UserListPage extends StatelessWidget {

  final List<UserEntity>? users;

  const UserListPage(this.users, {super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(LocaleKeys.button1.tr(), style: const TextStyle(color: Colors.white)),
        leading: IconButton(onPressed: () {
          Navigator.of(context).pop();
        }, icon: const Icon(Icons.arrow_back, color: Colors.red,)),
      ),
      body: Column(
        children: [
          OutlinedButton(
              onPressed: () {
                SharedPreferencesHelper().saveData(keyLogin,AppRoutes.tab1Home.path);
                context.go(AppRoutes.tab1Home.path);
              },
              child: const Text('go to list user')),
          Container(
            padding: const EdgeInsets.all(20),
            width: double.infinity,
            height: 500,
            child: ListView.separated(itemBuilder: (context, index) {
              return Text(users?[index].toJson().toString() ?? '', style: const TextStyle(color: Colors.black));
            }, separatorBuilder: (context, index) {
              return Container(
                color: Colors.grey,
                height: 1,
                margin: const EdgeInsets.symmetric(vertical: 10),
              );
            }, itemCount: users?.length ?? 0),
          ),
        ],
      ),
    );
  }
}
