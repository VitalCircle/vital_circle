import 'package:flutter/material.dart';

import 'colors.dart';

class MaterialThemeModule {
  static ThemeData build() {
    return ThemeData(
      errorColor: AppColors.error,
      fontFamily: 'Roboto',
      primaryColor: AppColors.brandPrimary,

      // App bar settings
      appBarTheme: const AppBarTheme(iconTheme: IconThemeData(color: AppColors.whiteHighEmphasis)),
      primaryTextTheme: const TextTheme(title: TextStyle(color: AppColors.whiteHighEmphasis)),

      // Text settings
      textTheme: const TextTheme(
        display3: TextStyle(color: AppColors.primaryTextColor, fontSize: 36),
        display2: TextStyle(fontSize: 32),
        display1: TextStyle(
            color: AppColors.darkMediumEmphasis,
            fontSize: 22,
            fontStyle: FontStyle.italic,
            fontWeight: FontWeight.normal),
      ),
    );
  }
}
