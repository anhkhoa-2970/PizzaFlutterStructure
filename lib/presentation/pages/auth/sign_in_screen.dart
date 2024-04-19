import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:testxxxx/core/theme/app_palette.dart';
import 'package:testxxxx/domain/entities/language_entity.dart';
import 'package:testxxxx/presentation/blocs/sign_in/sign_in_bloc.dart';
import 'package:testxxxx/presentation/widgets/input_text_field_widget.dart';
import 'package:testxxxx/presentation/widgets/loader.dart';
import 'package:testxxxx/utils/constants.dart';
import 'package:testxxxx/utils/shared_preferences.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  bool signInRequired = false;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  String? _errorMessage;
  LanguageEntity _selectedLanguage = LanguageEntity.getLanguageList().first;
  final _link = LayerLink();
  final OverlayPortalController _tooltipController = OverlayPortalController();
  final languageList = LanguageEntity.getLanguageList();
  bool expanded = false;
  OverlayEntry? entry;
  OverlayState? overlay;
  @override
  void initState() {
    super.initState();
    _initializeLanguage();
  }

  void _initializeLanguage() {
    // getLanguage().then((language) {
    //   setState(() {
    //     _selectedLanguage = language;
    //   });
    // }).catchError((error) {
    //   _selectedLanguage = LanguageEntity.getLanguageList().first;
    //   print('Error fetching initial language: $error');
    // });
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
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignInBloc, SignInState>(
        listener: (context, state) {
          switch(state.runtimeType) {
            case SignInSuccess:
              setState(() {
                _hideOverlayLoading();
                signInRequired = false;
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
                _errorMessage = 'Invalid email or password';
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
        child: Container(
          width: double.infinity,
          height: double.infinity,
          decoration: const BoxDecoration(
            gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  ColorAppPalette.colorMain,
                  ColorAppPalette.whiteColor,
                  ColorAppPalette.whiteColor,
                  ColorAppPalette.whiteColor
                ]),
          ),
          child: Form(
            key: _formKey,
            child:   Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                const SizedBox(height: 60),
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
                            ),
                          ),
                        );
                      },
                      child: ChooseLanguageWidget(
                        languageEntity: _selectedLanguage,
                        onTap: () {
                          expanded = !expanded;
                          onTap(expanded);
                        },
                      ),
                    )),
                SizedBox(width: double.infinity,height: 300,child:Image.asset('assets/icons/ic_logo_login.png'),),
                Text('Phone Number'),
                Container(
                  margin:const EdgeInsets.only(left: 24,right: 24),width: double.infinity,
                  height: 45,
                  child: CustomInputTextField(
                    controller: emailController,
                    hintText: 'Email',
                    obscureText: false,
                    keyboardType: KeyboardType.email,
                    prefixIcon: const Icon(CupertinoIcons.mail_solid),
                    errorMessage: _errorMessage,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please fill in this field';
                      } else if (!RegExp(r'^[\w-\.]+@([\w-]+.)+[\w-]{2,4}$')
                          .hasMatch(val)) {
                        return 'Please enter a valid email';
                      }
                      return null;
                    },
                  ),
                ),
                 Container(height: 10),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.9,
                  child: CustomInputTextField(
                    controller: passwordController,
                    hintText: 'Password',
                    obscureText: obscurePassword,
                    keyboardType: KeyboardType.password,
                    prefixIcon: const Icon(CupertinoIcons.lock_fill),
                    errorMessage: _errorMessage,
                    validator: (val) {
                      if (val!.isEmpty) {
                        return 'Please fill in this field';
                      } else if (!RegExp(
                              r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$')
                          .hasMatch(val)) {
                        return 'Please enter a valid password';
                      }
                      return null;
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
                ),
                const SizedBox(
                  height: 20,
                ),

                     SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              context.read<SignInBloc>().add(SignInRequired(
                                  emailController.text,
                                  passwordController.text));
                            }
                          },
                          style: TextButton.styleFrom(
                              elevation: 3.0,
                              backgroundColor: ColorAppPalette.greyColor,
                              foregroundColor: ColorAppPalette.whiteColor,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(60))),
                          child: const Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: 25, vertical: 5),
                            child: Text(
                              'Sign In',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600),
                            ),
                          ),
                        ),
                      )
                    // : const LoadingWidget()
              ],
            ) ,
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

Future<LanguageEntity> getLanguage() async {
  final jsonString = await SharedPreferencesHelper().loadData(keyLanguage);
  return jsonString != null
      ? LanguageEntity.fromJson(json.decode(jsonString ?? ''))
      : LanguageEntity.getLanguageList().first;
}

class ChooseLanguageWidget extends StatefulWidget {
  final LanguageEntity languageEntity;
  final VoidCallback? onTap;

  const ChooseLanguageWidget(
      {Key? key, required this.languageEntity, required this.onTap})
      : super(key: key);

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
                    widget.languageEntity.language,
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

  const LanguageDropdownWidget(
      {Key? key, this.onLanguageSelected, this.selectedLanguage})
      : super(key: key);

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
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(7),
          color: ColorAppPalette.whiteColor),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: _languageList!.map((language) {
          return InkWell(
            onTap: () async {
              final prefId = await LanguageEntity.getPref();
              if (prefId != null && language.id != prefId) {
                SharedPreferencesHelper().saveData(
                  keyLanguage,
                  json.encode(language.toJson()),
                );
              }
              widget.onLanguageSelected!(language);
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
                      color: language.id == widget.selectedLanguage?.id
                          ? Colors.blue
                          : Colors.grey,
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
