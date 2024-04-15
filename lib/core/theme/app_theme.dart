import 'package:flutter/material.dart';
import 'package:testxxxx/core/theme/app_palette.dart';

class AppTheme {
  static  _border([Color color = ColorAppPalette.borderColor]) => OutlineInputBorder(
    borderSide:  BorderSide(color: color, width: 1),
    borderRadius:  BorderRadius.circular(10),
  );

  static final darkThemeMode = ThemeData.dark().copyWith(
      scaffoldBackgroundColor: ColorAppPalette.backgroundColorNight,
      appBarTheme: const AppBarTheme(backgroundColor: ColorAppPalette.backgroundColorNight),
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(20),
          enabledBorder: _border(),
          focusedBorder: _border(ColorAppPalette.borderColorFocus)
      )
  );

  static final lightThemeMode = ThemeData.light().copyWith(
      scaffoldBackgroundColor: ColorAppPalette.backgroundColorLight,
      appBarTheme: const AppBarTheme(backgroundColor: ColorAppPalette.backgroundColorLight),
      inputDecorationTheme: InputDecorationTheme(
          contentPadding: const EdgeInsets.all(20),
          enabledBorder: _border(),
          focusedBorder: _border(ColorAppPalette.borderColorFocus)
      )
  );
}
