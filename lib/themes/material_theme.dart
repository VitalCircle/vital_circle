import 'package:flutter/material.dart';

import 'colors.dart';
import 'typography.dart';

class MaterialThemeModule {
  static ThemeData build() {
    final textTheme = _buildTextTheme();
    return ThemeData(
      appBarTheme: _buildAppBarTheme(textTheme),
      fontFamily: 'HKGrotesk',
      primaryColor: AppColors.primary,
      textTheme: textTheme,
    );
  }

  static AppBarTheme _buildAppBarTheme(TextTheme textTheme) {
    return AppBarTheme(
      actionsIconTheme: const IconThemeData(color: AppColors.primary),
      iconTheme: const IconThemeData(color: AppColors.primary),
      textTheme: textTheme.copyWith(
        title: textTheme.title.copyWith(
          color: AppColors.primary,
        ),
      ),
    );
  }

  static TextTheme _buildTextTheme() {
    return const TextTheme(
      // Set all font-sizes to 1 so they must be intentionally styled
      display4: TextStyle(fontSize: 1),
      display3: TextStyle(fontSize: 1),
      display2: TextStyle(fontSize: 1),
      display1: TextStyle(fontSize: 1),
      headline: TextStyle(fontSize: 1),
      // Used for app bar and dialog titles
      title: TextStyle(
        fontFamily: 'HKGrotesk',
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      // used for input text, list tile title
      subhead: TextStyle(
        fontFamily: 'HKGrotesk',
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
      body1: AppTypography.bodyRegular1,
      body2: AppTypography.bodyRegular2,
      // used for input error text
      caption: TextStyle(fontSize: 1),
      button: TextStyle(
        fontFamily: 'HKGrotesk',
        fontSize: 16,
        fontWeight: FontWeight.w700,
      ),
      subtitle: TextStyle(fontSize: 1),
      overline: TextStyle(fontSize: 1),
    );
  }
}
