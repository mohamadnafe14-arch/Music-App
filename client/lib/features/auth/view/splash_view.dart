import 'package:client/core/utils/app_router.dart';
import 'package:client/features/auth/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView> {
  @override
  void initState() {
    Future.microtask(() {
      ref.read(authViewModelProvider.notifier).getUser();
    });
    ref.listenManual(
      authViewModelProvider,
      (_, next) {
        next.when(
          data: (data) {
            Future.delayed(
              const Duration(seconds: 2),
              () {
                // ignore: use_build_context_synchronously
                GoRouter.of(context).go(AppRouter.homeView);
              },
            );
          },
          error: (error, stackTrace) =>
            {
              Future.delayed(
                const Duration(seconds: 2),
                () {
                  // ignore: use_build_context_synchronously
                  GoRouter.of(context).go(AppRouter.signInView);
                },
              ),
            },
          loading: () {},
        );
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Center(
            child: Icon(
          Icons.music_note,
          size: 100.r,
        )),
      ),
    );
  }
}
