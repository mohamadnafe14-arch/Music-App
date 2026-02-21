import 'package:client/core/theme/app_theme.dart';
import 'package:client/core/utils/app_router.dart';
import 'package:client/features/auth/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final container = ProviderContainer();
  await container.read(authViewModelProvider.notifier).initSharedPref();
  runApp(
    UncontrolledProviderScope(
      container: container,
      child: const MusicApp(),
    ),
  );
}

class MusicApp extends StatelessWidget {
  const MusicApp({super.key});
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 812),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) => MaterialApp.router(
        routerConfig: AppRouter.router,
        theme: AppTheme.appTheme,
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
