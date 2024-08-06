import 'package:flutter/material.dart';
import 'package:mobile_test/core/utils/color_manager.dart';

class FontFamilyConstants {
  static const String fontFamily_1 = "Oxanium";
  static const String fontFamily_2 = "AnonymousPro";
}

class FontWeightManager {
  static const FontWeight regular = FontWeight.w400;
  static const FontWeight semiBold = FontWeight.w600;
  static const FontWeight bold = FontWeight.w700;
}

ThemeData getApplicationTheme() {
  return ThemeData(
    textTheme: TextTheme(
      headlineLarge: TextStyle(
        fontFamily: FontFamilyConstants.fontFamily_1,
        fontSize: 40,
        fontWeight: FontWeightManager.semiBold,
        color: ColorManager.primary,
      ),
      bodySmall: TextStyle(
        fontFamily: FontFamilyConstants.fontFamily_2,
        fontSize: 18,
      ),
      bodyMedium: TextStyle(
        fontFamily: FontFamilyConstants.fontFamily_2,
        fontSize: 24,
      ),
    ),
  );
}
