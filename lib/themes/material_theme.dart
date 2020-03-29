import 'package:flutter/material.dart';

import 'colors.dart';

class MaterialThemeModule {
  static ThemeData build() {
    return ThemeData(
      errorColor: AppColors.error,
      fontFamily: 'Roboto',
      primaryColor: AppColors.primary,

      // App bar settings
      appBarTheme: const AppBarTheme(
          iconTheme: IconThemeData(color: AppColors.whiteHighEmphasis)),
      primaryTextTheme:
          const TextTheme(title: TextStyle(color: AppColors.whiteHighEmphasis)),

      // Text settings
      textTheme: const TextTheme(
          display4: TextStyle(color: AppColors.primaryTextColor),
          body1: TextStyle(fontSize: 32)),
    );
  }
}
