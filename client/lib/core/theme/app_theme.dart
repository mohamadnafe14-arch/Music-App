import 'package:client/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AppTheme {
  static final appTheme = ThemeData.dark().copyWith(
    scaffoldBackgroundColor: AppPalette.backgroundColor,
    appBarTheme:const AppBarTheme(backgroundColor: AppPalette.backgroundColor),
    inputDecorationTheme: InputDecorationTheme(
      border: OutlineInputBorder(borderRadius: BorderRadius.circular(8.r)),
      enabledBorder: _border(),
      focusedBorder: _border(AppPalette.gradient2),
      errorBorder: _border(AppPalette.errorColor),
      contentPadding: EdgeInsets.all(16.h),
    ),
  );
  static InputBorder _border([Color color = AppPalette.borderColor]) =>
      OutlineInputBorder(
        borderRadius: BorderRadius.circular(10.r),
        borderSide: BorderSide(color: color, width: 3.w),
      );
}
