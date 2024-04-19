import 'package:flutter/material.dart';
import 'package:testxxxx/core/theme/app_palette.dart';

class LoadingWidget extends StatelessWidget {
  const LoadingWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return  Center(child: Container(color: ColorAppPalette.transparentColor,child: CircularProgressIndicator()),);
  }
}

Widget buildOverlayLoading() => Container(
  color: Colors.black.withOpacity(0.7),
  child: const Align(
    alignment: Alignment.center,
    child: CircularProgressIndicator(color: Colors.lightBlue),
  ),
);
