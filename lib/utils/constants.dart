import 'dart:ui';

import 'package:testxxxx/generated/locale_keys.g.dart';

const int errorFromFirebase = 1000;

const String keyLogin = "key_login";
const String keyLanguage = "key_language";
const Locale localeVi = Locale('vi', 'VN');
const Locale localeEn = Locale('en', 'US');

enum KeyboardType { phone, text, number, password, email }

enum LanguageType {
  VN,
  ENGLISH,
}

extension LaguageTypeExtension on LanguageType {
  int get type {
    switch (this) {
      case LanguageType.VN:
        return 1;
      case LanguageType.ENGLISH:
        return 2;
    }
  }

  String get code {
    switch (this) {
      case LanguageType.VN:
        return LocaleKeys.vietnamese.substring(0,1);
      case LanguageType.ENGLISH:
        return LocaleKeys.english.substring(0,1);
    }
  }
}
