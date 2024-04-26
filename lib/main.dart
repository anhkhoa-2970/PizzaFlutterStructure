import 'package:easy_localization/easy_localization.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:path/path.dart';
import 'package:testxxxx/config/app_router.dart';
import 'package:testxxxx/config/injection.dart';
import 'package:testxxxx/core/network_services/api_service.dart';
import 'package:testxxxx/core/theme/app_theme.dart';
import 'package:logger/logger.dart';
import 'package:testxxxx/presentation/blocs/change_language/change_language_bloc.dart';
import 'package:testxxxx/presentation/blocs/sign_in/sign_in_bloc.dart';
import 'package:testxxxx/presentation/blocs/sign_up/sign_up_bloc.dart';
import 'package:testxxxx/presentation/blocs/user_bloc.dart';
import 'package:testxxxx/utils/constants.dart';
import 'package:testxxxx/utils/shared_preferences.dart';
import 'package:testxxxx/utils/simple_bloc_observer.dart';
import 'package:testxxxx/utils/utils.dart';
import 'dart:developer' as dev show log;

final logger = Logger();
String startDestination = '';

void main() async {
  WidgetsBinding widgetsFlutterBinding = WidgetsFlutterBinding.ensureInitialized();
  FlutterNativeSplash.preserve(widgetsBinding: widgetsFlutterBinding);
  await Firebase.initializeApp();
  await EasyLocalization.ensureInitialized();
  await SharedPreferencesHelper().init();
  Bloc.observer = SimpleBlocObserver();
  startDestination = await checkLogin();
  configureDependencies();
  configureDio();
  final language = await getLanguageFromSharedPreferences();
  Locale locale = language.id == 1 ? localeVi : localeEn;
  FlutterNativeSplash.remove();
  runApp(
    EasyLocalization(
      supportedLocales: const [localeEn, localeVi],
      path: 'assets/translations',
      startLocale: locale,
      fallbackLocale: localeVi,
      // Add fallback locale if necessary
      child: MyApp(locale: locale),
    ),
  );
}

class MyApp extends StatefulWidget {
  final Locale locale;

  const MyApp({Key? key, required this.locale}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late Locale _currentLocale;

  @override
  void initState() {
    super.initState();
    _currentLocale = widget.locale;
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => getIt<UserBloc>()),
        BlocProvider(create: (context) => getIt<SignInBloc>()),
        BlocProvider(create: (context) => getIt<SignUpBloc>()),
        BlocProvider(create: (context) => getIt<ChangeLanguageBloc>()),
      ],
      child: BlocListener<ChangeLanguageBloc, ChangeLanguageState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case ChangeNewLanguageState:
              setState(() {
                _currentLocale = context.locale;
              });
          }
        },
        child: MaterialApp.router(
          localizationsDelegates: context.localizationDelegates,
          supportedLocales: context.supportedLocales,
          locale: _currentLocale,
          title: 'Flutter Demo',
          themeMode: MediaQuery.of(context).platformBrightness == Brightness.dark ? ThemeMode.dark : ThemeMode.light,
          theme: AppTheme.lightThemeMode,
          darkTheme: AppTheme.darkThemeMode,
          routerConfig: router,
          debugShowCheckedModeBanner: false,
          builder: (context, router) {
            return router!;
          },
        ),
      ),
    );
  }
}
