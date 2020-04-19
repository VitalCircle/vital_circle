import 'package:flutter/widgets.dart';
import 'colors.dart';

class AppTypography {
  static const TextStyle h1 = TextStyle(
    color: AppColors.primary,
    fontFamily: 'LeagueSpartan',
    fontSize: 24,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle h2 = TextStyle(
    color: AppColors.primary,
    fontFamily: 'LeagueSpartan',
    fontSize: 16,
    fontWeight: FontWeight.bold,
  );

  static const TextStyle bodyBold = TextStyle(
    color: AppColors.primary,
    fontFamily: 'HKGrotesk',
    fontSize: 16,
    fontWeight: FontWeight.w700,
  );

  static const TextStyle bodySemiBold = TextStyle(
    color: AppColors.primary,
    fontFamily: 'HKGrotesk',
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );

  static const TextStyle bodyRegular1 = TextStyle(
    color: AppColors.primary,
    fontFamily: 'HKGrotesk',
    fontSize: 16,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle bodyRegular2 = TextStyle(
    color: AppColors.primary,
    fontFamily: 'HKGrotesk',
    fontSize: 14,
    fontWeight: FontWeight.w400,
  );

  static const TextStyle calendarDay = TextStyle(
    color: AppColors.primary,
    fontFamily: 'HKGrotesk',
    fontSize: 16,
    fontWeight: FontWeight.w600,
  );
}
