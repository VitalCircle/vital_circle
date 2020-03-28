import 'package:flutter/material.dart';

import 'colors.dart';

class MaterialThemeModule {
  static ThemeData build() {
    return ThemeData(errorColor: AppColors.error, fontFamily: 'Roboto', primaryColor: AppColors.primary);
  }
}
