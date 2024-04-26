import 'dart:convert';

import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:testxxxx/core/theme/app_palette.dart';
import 'package:testxxxx/domain/entities/language_entity.dart';
import 'package:testxxxx/presentation/blocs/change_language/change_language_bloc.dart';
import 'package:testxxxx/presentation/blocs/sign_in/sign_in_bloc.dart';
import 'package:testxxxx/presentation/widgets/input_text_field_widget.dart';
import 'package:testxxxx/presentation/widgets/loader.dart';
import 'package:testxxxx/utils/constants.dart';
import 'package:testxxxx/utils/shared_preferences.dart';

import '../../../config/app_routes.dart';
import '../../../config/injection.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../utils/utils.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  bool signInRequired = false;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  String? _errorEmailMessage;
  String? _errorPasswordMessage;
  LanguageEntity? _selectedLanguage;
  final _link = LayerLink();
  final OverlayPortalController _tooltipController = OverlayPortalController();
  final languageList = LanguageEntity.getLanguageList();
  bool expanded = false;
  OverlayEntry? entry;
  OverlayState? overlay;
  bool isEmailPasswordNotEmpty = false;

  @override
  void initState() {
    super.initState();
    emailController.addListener(updateButtonState);
    passwordController.addListener(updateButtonState);
    _initSelectedLanguage();
  }

  Future<void> _initSelectedLanguage() async {
    final language = await getLanguageFromSharedPreferences();
    setState(() {
      _selectedLanguage = language;
    });
  }

  void updateButtonState() {
    setState(() {
      // Check if both email and password fields are not empty
      isEmailPasswordNotEmpty = emailController.text.isNotEmpty && passwordController.text.isNotEmpty;
    });
  }

  void _showOverlayLoading() {
    entry = OverlayEntry(builder: (context) => buildOverlayLoading());
    overlay = Overlay.of(context);
    overlay?.insert(entry!);
  }

  void _hideOverlayLoading() {
    if (entry != null) {
      entry?.remove();
      entry = null;
    }
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    _hideOverlayLoading();
    emailController.removeListener(updateButtonState);
    passwordController.removeListener(updateButtonState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case SignInSuccess:
              setState(() {
                _hideOverlayLoading();
                signInRequired = false;
                SharedPreferencesHelper().saveData(keyLogin,AppRoutes.tab1Home.path);
                context.go(AppRoutes.tab1Home.path);
              });
              break;
            case SignInProcess:
              setState(() {
                // const CircularProgressIndicator();
                _showOverlayLoading();
                signInRequired = true;
              });
              break;
            case SignInFailure:
              setState(() {
                _hideOverlayLoading();
                signInRequired = false;
                _errorEmailMessage = 'Invalid email or password';
                _errorPasswordMessage = 'Invalid email or password';
              });
          }
          // if (state is SignInSuccess) {
          //   setState(() {
          //     signInRequired = false;
          //   });
          // } else if (state is SignInProcess) {
          //   setState(() {
          //      const CircularProgressIndicator();
          //     signInRequired = true;
          //   });
          // } else if (state is SignInFailure) {
          //   setState(() {
          //     signInRequired = false;
          //     _errorMessage = 'Invalid email or password';
          //   });
          // }
        },
        child: GestureDetector(
          onTap: () {
            FocusScope.of(context).requestFocus(FocusNode());
          },
          child: Container(
            width: double.infinity,
            height: double.infinity,
            decoration: const BoxDecoration(
              gradient: LinearGradient(begin: Alignment.topLeft, end: Alignment.bottomRight, colors: [ColorAppPalette.colorMain, ColorAppPalette.whiteColor, ColorAppPalette.whiteColor, ColorAppPalette.whiteColor]),
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    const SizedBox(height: 60),
                    Padding(
                      padding: const EdgeInsets.only(right: 24),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          CompositedTransformTarget(
                              link: _link,
                              child: OverlayPortal(
                                controller: _tooltipController,
                                overlayChildBuilder: (BuildContext context) {
                                  return CompositedTransformFollower(
                                    link: _link,
                                    targetAnchor: Alignment.bottomLeft,
                                    child: Align(
                                      alignment: AlignmentDirectional.topStart,
                                      child: LanguageDropdownWidget(
                                        selectedLanguage: _selectedLanguage,
                                        onLanguageSelected: (language) {
                                          setState(() {
                                            _selectedLanguage = language;
                                            expanded = !expanded;
                                            onTap(expanded);
                                          });
                                        },
                                        onChangeLocale: (locale) {
                                          setState(() async {
                                            context.setLocale(locale);
                                            getIt<ChangeLanguageBloc>().add(ChangeLanguageEvent(locale));
                                          });
                                        },
                                      ),
                                    ),
                                  );
                                },
                                child: ChooseLanguageWidget(
                                  languageEntity: _selectedLanguage ?? languageList.first,
                                  onTap: () {
                                    expanded = !expanded;
                                    onTap(expanded);
                                  },
                                ),
                              ))
                        ],
                      ),
                    ),
                  Hero(
                    tag: 'logo',
                    child: SizedBox(
                      width: 200,
                      height: 200,
                      child: Image.asset('assets/icons/ic_logo_login.png'),
                    ),
                  ),

                    CustomInputTextField(
                      marginHorizontal: 24,
                      controller: emailController,
                      hintText: LocaleKeys.email.tr(),
                      obscureText: false,
                      keyboardType: KeyboardType.email,
                      prefixIcon: const Icon(CupertinoIcons.mail_solid),
                      errorMessage: _errorEmailMessage,
                      focusNode: emailFocusNode,
                      onChanged: (text) {
                        setState(() {
                          if (text!.isEmpty) {
                            _errorEmailMessage = 'Please fill in this field';
                          } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$').hasMatch(text)) {
                            _errorEmailMessage = 'Please enter a valid email';
                          } else {
                            _errorEmailMessage = null;
                          }
                        });
                      },
                    ),
                    Container(height: 10),
                    CustomInputTextField(
                      marginHorizontal: 24,
                      controller: passwordController,
                      hintText: LocaleKeys.password.tr(),
                      obscureText: obscurePassword,
                      keyboardType: KeyboardType.password,
                      prefixIcon: const Icon(CupertinoIcons.lock_fill),
                      errorMessage: _errorPasswordMessage,
                      focusNode: passwordFocusNode,
                      onChanged: (text) {
                        if (text!.isEmpty) {
                          _errorPasswordMessage = 'Please fill in this field';
                        } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$').hasMatch(text)) {
                          _errorPasswordMessage = 'Please enter a valid password';
                        } else {
                          _errorPasswordMessage = null;
                        }
                      },
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscurePassword = !obscurePassword;
                            if (obscurePassword) {
                              iconPassword = CupertinoIcons.eye_fill;
                            } else {
                              iconPassword = CupertinoIcons.eye_slash_fill;
                            }
                          });
                        },
                        icon: Icon(iconPassword),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),

                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextButton(
                        onPressed: () {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (_formKey.currentState!.validate()) {
                            context.read<SignInBloc>().add(SignInRequiredEvent(emailController.text, passwordController.text));
                          }
                        },
                        style: TextButton.styleFrom(
                            elevation: 3.0,
                            backgroundColor: isEmailPasswordNotEmpty
                                ? ColorAppPalette.colorMain
                                : Colors.grey[300],
                            foregroundColor: ColorAppPalette.whiteColor,
                            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(60))),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 25, vertical: 5),
                          child: Text(
                            LocaleKeys.sign_in.tr(),
                            textAlign: TextAlign.center,
                            style: const TextStyle(color: Colors.white, fontSize: 16, fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    RichText(
                      text: TextSpan(
                        text: LocaleKeys.dont_have_account.tr(),
                        style: Theme.of(context).textTheme.titleMedium,
                        children: [
                          WidgetSpan(
                            alignment: PlaceholderAlignment.middle,
                            child: GestureDetector(
                              onTap: () {
                                context.go(AppRoutes.signup.path);
                              },
                              child: Text(
                                LocaleKeys.sign_up.tr(),
                                style: Theme.of(context).textTheme.titleMedium?.copyWith(color: ColorAppPalette.colorMain),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),

                    // : const LoadingWidget()
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  void onTap(bool isShow) {
    if (isShow) {
      _tooltipController.toggle();
    } else {
      _tooltipController.hide();
    }
  }
}

class ChooseLanguageWidget extends StatefulWidget {
  final LanguageEntity languageEntity;
  final VoidCallback? onTap;

  const ChooseLanguageWidget({Key? key, required this.languageEntity, required this.onTap}) : super(key: key);

  @override
  State<ChooseLanguageWidget> createState() => _ChooseLanguageWidgetState();
}

class _ChooseLanguageWidgetState extends State<ChooseLanguageWidget> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        InkWell(
          onTap: widget.onTap,
          child: Container(
            height: 32,
            width: 145,
            padding: const EdgeInsets.only(left: 7, right: 7),
            decoration: BoxDecoration(
              color: ColorAppPalette.whiteColor,
              borderRadius: BorderRadius.circular(10),
              border: Border.all(color: ColorAppPalette.borderColor),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  widget.languageEntity.flag,
                  width: 22,
                  height: 16,
                ),
                const SizedBox(width: 7),
                Expanded(
                  child: Text(
                    widget.languageEntity.id == 1 ? LocaleKeys.vietnamese.tr() : LocaleKeys.english.tr(),
                    style: const TextStyle(
                      color: ColorAppPalette.greyColor,
                      fontSize: 14,
                    ),
                  ),
                ),
                const SizedBox(width: 7),
                Image.asset('assets/icons/ic_drop_down.png'),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class LanguageDropdownWidget extends StatefulWidget {
  final LanguageEntity? selectedLanguage;
  final Function(LanguageEntity)? onLanguageSelected;
  final Function(Locale)? onChangeLocale;

  const LanguageDropdownWidget({Key? key, this.onLanguageSelected, this.selectedLanguage, this.onChangeLocale}) : super(key: key);

  @override
  State<LanguageDropdownWidget> createState() => _LanguageDropdownWidgetState();
}

class _LanguageDropdownWidgetState extends State<LanguageDropdownWidget> {
  List<LanguageEntity>? _languageList;

  @override
  void initState() {
    super.initState();
    _languageList = LanguageEntity.getLanguageList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 145,
      padding: const EdgeInsets.all(7),
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(7), color: ColorAppPalette.whiteColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _languageList!.map((language) {
          return InkWell(
            onTap: () async {
              widget.onLanguageSelected!(language);
              final prefId = await LanguageEntity.getPref();
              if (prefId != null && language.id != prefId) {
                SharedPreferencesHelper().saveData(
                  keyLanguage,
                  json.encode(language.toJson()),
                );
                Locale locale = language.id == 1 ? localeVi : localeEn;
                widget.onChangeLocale!(locale);
              }
            },
            child: SizedBox(
              height: 24,
              child: Row(
                children: [
                  Image.asset(language.flag, height: 20, width: 20),
                  const SizedBox(width: 7),
                  Text(
                    language.language,
                    style: TextStyle(
                      color: language.id == widget.selectedLanguage?.id ? Colors.blue : Colors.grey,
                    ),
                  ),
                ],
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
