import 'package:client/core/theme/app_palette.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final darkMode = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPalette.backgroundColor,
  );
}
