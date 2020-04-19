import 'dart:ui';

import 'package:flutter/material.dart';

class AppColors {
  // Core
  static const Color primary = Color(0xFF042240);
  static const Color secondary = Color(0xFF018786);
  static const Color error = Color(0xFFFF0C3E);
  static const Color disabled = Color(0xFF9E9E9E);

  // Text
  static const Color textLight = Color(0xFFFFFFFF);

  // Button
  static const Color buttonDisabled = disabled;

  // Calendar
  static const Color today = Color(0xFFCFD8DC);
  static const Color checkinGood = primary;
  static const Color checkinBad = error;

  // Misc
  static const Color googleBtnBackground = Color.fromARGB(255, 66, 133, 244);
  static const Color anonymousBtnBackground = Color.fromARGB(255, 61, 61, 61);
  static const Color modalBackground = Color.fromARGB(255, 0, 0, 0);
  static const Color cardBorder = Color(0xFFCFD8DC);
}
