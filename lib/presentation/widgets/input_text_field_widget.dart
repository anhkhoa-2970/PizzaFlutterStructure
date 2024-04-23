import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:testxxxx/core/theme/app_palette.dart';

import '../../utils/constants.dart';

class CustomInputTextField extends StatelessWidget {
  final TextEditingController controller;
  final String hintText;
  final bool obscureText;
  final KeyboardType keyboardType;
  final Widget? suffixIcon;
  final VoidCallback? onTap;
  final Widget? prefixIcon;
  final String? Function(String?)? validator;
  final FocusNode? focusNode;
  final String? errorMessage;
  final String? Function(String?)? onChanged;
  final double? marginHorizontal;
  final double? height;

  const CustomInputTextField(
      {super.key,
      required this.controller,
      required this.hintText,
      required this.obscureText,
      required this.keyboardType,
      this.suffixIcon,
      this.onTap,
      this.prefixIcon,
      this.validator,
      this.focusNode,
      this.errorMessage,
      this.onChanged,
      this.marginHorizontal,
      this.height});

  @override
  Widget build(BuildContext context) {
    TextInputType keyboardType;
    switch (this.keyboardType) {
      case KeyboardType.phone:
        keyboardType = TextInputType.phone;
        break;
      case KeyboardType.number:
        keyboardType = TextInputType.number;
        break;
      case KeyboardType.password:
        keyboardType = TextInputType.text;
        break;
      case KeyboardType.email:
        keyboardType = TextInputType.emailAddress;
        break;
      case KeyboardType.text:
      default:
        keyboardType = TextInputType.text;
    }
    return Container(
      padding: EdgeInsets.symmetric(horizontal: marginHorizontal ?? 0.0),
      height: height,
      child: Center( // Wrap the TextFormField with Center
        child: TextFormField(
          validator: validator,
          controller: controller,
          obscureText: obscureText,
          keyboardType: keyboardType,
          focusNode: focusNode,
          onTap: onTap,
          textInputAction: TextInputAction.next,
          onChanged: onChanged,
          decoration: InputDecoration(
            suffixIcon: suffixIcon,
            prefixIcon: prefixIcon,
            fillColor: ColorAppPalette.whiteColor,
            filled: true,
            hintText: hintText,
            hintStyle: TextStyle(color: Colors.grey[500]),
            errorText: errorMessage,
            contentPadding: const EdgeInsets.symmetric(vertical: 0), // Adjust vertical padding here
          ),
        ),
      ),
    );
  }
}
