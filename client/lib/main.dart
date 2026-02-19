import 'package:client/core/theme/app_theme.dart';
import 'package:client/features/auth/view/sign_in_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const ProviderScope(child: MusicApp()));
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp(
        theme: AppTheme.appTheme,
        home: const SignInView(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
