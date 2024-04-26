import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:testxxxx/config/app_routes.dart';
import 'package:testxxxx/domain/entities/user_entity.dart';
import 'package:testxxxx/presentation/pages/auth/sing_up_screen.dart';
import 'package:testxxxx/presentation/pages/tab1_page.dart';
import 'package:testxxxx/presentation/pages/tab2_page.dart';
import 'package:testxxxx/presentation/pages/tab3_page.dart';
import 'package:testxxxx/presentation/pages/tab_home_page.dart';
import 'package:testxxxx/presentation/pages/user_list_page.dart';
import '../main.dart';
import '../presentation/pages/auth/sign_in_screen.dart';
import '../utils/constants.dart';
import '../utils/shared_preferences.dart';

final _rootNavigatorKey = GlobalKey<NavigatorState>();
final _shellNavigator1Key = GlobalKey<NavigatorState>(debugLabel: 'shell1');
final _shellNavigator2Key = GlobalKey<NavigatorState>(debugLabel: 'shell2');
final _shellNavigator3Key = GlobalKey<NavigatorState>(debugLabel: 'shell3');
final scaffoldKey = GlobalKey<ScaffoldState>();

final GoRouter router = GoRouter(
    debugLogDiagnostics: kDebugMode,
    navigatorKey: _rootNavigatorKey,
    routes: [
      GoRoute(
        path: AppRoutes.login.path,
        name: AppRoutes.login.name,
        builder: (context, state) => const SignInScreen(),
        routes: [
          GoRoute(
            path: AppRoutes.signup.name,
            name: AppRoutes.signup.name,
            builder: (context, state) {
              return const SignUpScreen();
            },
          ),
        ]
      ),

      StatefulShellRoute.indexedStack(
        branches: [createTab1Routes(), createTab2Routes(), createTab3Routes()],
        builder: (context, state, navigationShell) {
          return TabHomePage(navigationShell: navigationShell);
        },
      )
    ],
    initialLocation: startDestination );

StatefulShellBranch createTab1Routes() {
  return StatefulShellBranch(routes: [
    GoRoute(
      path: AppRoutes.tab1Home.path,
      name: AppRoutes.tab1Home.name,
      builder: (context, state) => const Tab1Page(),
    ),
    GoRoute(
      path: AppRoutes.tab1Details.path,
      name: AppRoutes.tab1Details.name,
      builder: (context, state) => const Tab1DetailPage(),
    )
  ], navigatorKey: _shellNavigator1Key);
}

StatefulShellBranch createTab2Routes() {
  return StatefulShellBranch(routes: [
    GoRoute(
      path: AppRoutes.tab2Home.path,
      name: AppRoutes.tab2Home.name,
      builder: (context, state) => const Tab2Page(),
    ),
    GoRoute(
      path: AppRoutes.tab2Details.path,
      name: AppRoutes.tab2Details.name,
      builder: (context, state) => const Tab2DetailPage(),
    )
  ], navigatorKey: _shellNavigator2Key);
}

StatefulShellBranch createTab3Routes() {
  return StatefulShellBranch(routes: [
    GoRoute(
      path: AppRoutes.tab3Home.path,
      name: AppRoutes.tab3Home.name,
      builder: (context, state) => const Tab3Page(),
    ),
    GoRoute(
      path: AppRoutes.tab3Details.path,
      name: AppRoutes.tab3Details.name,
      builder: (context, state) => const Tab3DetailPage(),
    )
  ], navigatorKey: _shellNavigator3Key);
}


Future<String> checkLogin() async {
  String? isLogin = await SharedPreferencesHelper().loadData(keyLogin);
  if (isLogin != null && isLogin.isNotEmpty) {
    return AppRoutes.tab1Home.path;
  } else {
    return AppRoutes.login.path;
  }
}
