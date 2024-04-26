import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

import '../../../config/app_routes.dart';
import '../../../core/theme/app_palette.dart';
import '../../../generated/locale_keys.g.dart';
import '../../../utils/constants.dart';
import '../../blocs/sign_up/sign_up_bloc.dart';
import '../../widgets/input_text_field_widget.dart';
import '../../widgets/loader.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final FocusNode nameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode passwordFocusNode = FocusNode();
  final FocusNode confirmPasswordFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();

  final _formKey = GlobalKey<FormState>();
  bool signInRequired = false;
  IconData iconPassword = CupertinoIcons.eye_fill;
  bool obscurePassword = true;
  bool obscureConfirmPassword = true;
  String? _errorNameMessage;
  String? _errorEmailMessage;
  String? _errorPasswordMessage;
  String? _errorConfirmPasswordMessage;
  String? _errorPhoneNumberMessage;
  bool isEnableButton = false;
  OverlayEntry? entry;
  OverlayState? overlay;

  @override
  void initState() {
    super.initState();
    nameController.addListener(updateButtonState);
    emailController.addListener(updateButtonState);
    passwordController.addListener(updateButtonState);
    confirmPasswordController.addListener(updateButtonState);
  }

  void updateButtonState() {
    setState(() {
      // Check if both email and password fields are not empty
      isEnableButton =
          emailController.text.isNotEmpty && passwordController.text.isNotEmpty && confirmPasswordController.text.isNotEmpty && nameController.text.isNotEmpty;
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
    nameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    phoneNumberController.dispose();
    _hideOverlayLoading();
    emailController.removeListener(updateButtonState);
    passwordController.removeListener(updateButtonState);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SignUpBloc, SignUpState>(
        listener: (context, state) {
          switch (state.runtimeType) {
            case SignUpSuccess:
              setState(() {
                _hideOverlayLoading();
                signInRequired = false;
              });
              break;
            case SignUpProcess:
              setState(() {
                // const CircularProgressIndicator();
                _showOverlayLoading();
                signInRequired = true;
              });
              break;
            case SignUpFailure:
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
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [ColorAppPalette.colorMain, ColorAppPalette.whiteColor, ColorAppPalette.whiteColor, ColorAppPalette.whiteColor]),
            ),
            child: Form(
              key: _formKey,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: 'logo',
                          child: SizedBox(
                            width: 200,
                            height: 200,
                            child: Image.asset('assets/icons/ic_logo_login.png'),
                          ),
                        ),
                      ],
                    ),
                    CustomInputTextField(
                      marginHorizontal: 24,
                      controller: nameController,
                      hintText: LocaleKeys.user_name.tr(),
                      obscureText: false,
                      keyboardType: KeyboardType.text,
                      prefixIcon: const Icon(CupertinoIcons.person_fill),
                      errorMessage: _errorNameMessage,
                      focusNode: nameFocusNode,
                      onChanged: (text) {
                        setState(() {
                          if (text!.isEmpty) {
                            _errorNameMessage = 'Please fill in this field';
                          } else {
                            _errorNameMessage = null;
                          }
                        });
                      },
                    ),
                    Container(height: 10),
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

                    Container(height: 10),

                    CustomInputTextField(
                      marginHorizontal: 24,
                      controller: confirmPasswordController,
                      hintText: LocaleKeys.confirm_password.tr(),
                      obscureText: obscureConfirmPassword,
                      keyboardType: KeyboardType.password,
                      prefixIcon: const Icon(CupertinoIcons.lock_fill),
                      errorMessage: _errorConfirmPasswordMessage,
                      focusNode: confirmPasswordFocusNode,
                      onChanged: (text) {
                        setState(() {
                          if (text!.isEmpty) {
                            _errorConfirmPasswordMessage = 'Please fill in this field';
                          } else if (!RegExp(r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\$&*~`)\%\-(_+=;:,.<>/?"[{\]}\|^]).{8,}$').hasMatch(text)) {
                            _errorConfirmPasswordMessage = 'Please enter a valid password';
                          } else if (passwordController.text != text) {
                            _errorConfirmPasswordMessage = 'Confirm password not match with password';
                          } else {
                            _errorConfirmPasswordMessage = null;
                          }
                        });
                      },
                      suffixIcon: IconButton(
                        onPressed: () {
                          setState(() {
                            obscureConfirmPassword = !obscureConfirmPassword;
                            if (obscureConfirmPassword) {
                              iconPassword = CupertinoIcons.eye_fill;
                            } else {
                              iconPassword = CupertinoIcons.eye_slash_fill;
                            }
                          });
                        },
                        icon: Icon(iconPassword),
                      ),
                    ),

                    Container(height: 10),

                    CustomInputTextField(
                      marginHorizontal: 24,
                      controller: phoneNumberController,
                      hintText: LocaleKeys.phone_number.tr(),
                      obscureText: false,
                      keyboardType: KeyboardType.number,
                      prefixIcon: const Icon(CupertinoIcons.phone_fill),
                      errorMessage: _errorPhoneNumberMessage,
                      focusNode: phoneNumberFocusNode,
                      onChanged: (text) {
                        setState(() {
                          if (text != '' && !RegExp(r'^[0-9]+$').hasMatch(text!)) {
                            _errorPhoneNumberMessage = 'Please enter a valid phone number';
                          } else {
                            _errorPhoneNumberMessage = null;
                          }
                        });
                      },
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
                            context.read<SignUpBloc>().add(SignUpRequiredEvent(
                                name: nameController.text, email: emailController.text, password: passwordController.text, phoneNumber: phoneNumberController.text));
                          }
                        },
                        style: TextButton.styleFrom(
                            elevation: 3.0,
                            backgroundColor: isEnableButton ? ColorAppPalette.colorMain : Colors.grey[300],
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
                                context.pop();
                              },
                              child: Text(
                                LocaleKeys.sign_in.tr(),
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
}
