import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:testxxxx/config/app_router.dart';
import 'package:testxxxx/config/injection.dart';
import 'package:testxxxx/core/network_services/api_service.dart';
import 'package:testxxxx/core/theme/app_theme.dart';
import 'package:testxxxx/generated/locale_keys.g.dart';
import 'package:logger/logger.dart';
import 'package:testxxxx/presentation/blocs/sign_in/sign_in_bloc.dart';
import 'package:testxxxx/presentation/blocs/user_bloc.dart';
import 'package:testxxxx/utils/shared_preferences.dart';
import 'package:testxxxx/utils/simple_bloc_observer.dart';

final logger = Logger();
String startDestination ='';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await SharedPreferencesHelper().init();
  Bloc.observer = SimpleBlocObserver();
  startDestination = await checkLogin();
  configureDependencies();
  configureDio();
  runApp(
    EasyLocalization(
        supportedLocales: const [Locale('en'), Locale('vn')],
        path: 'assets/translations',
        child: const MyApp()),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<UserBloc>()),
        BlocProvider(create: (context) => getIt<SignInBloc>())
      ],
      child: MaterialApp.router(
        localizationsDelegates: context.localizationDelegates,
        supportedLocales: context.supportedLocales,
        locale: context.locale,
        title: 'Flutter Demo',
        themeMode: MediaQuery.of(context).platformBrightness == Brightness.dark
            ? ThemeMode.dark
            : ThemeMode.light,
        theme: AppTheme.lightThemeMode,
        darkTheme: AppTheme.darkThemeMode,
        routerConfig: router,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}