import 'package:client/features/auth/view/sign_in_view.dart';
import 'package:client/features/auth/view/sign_up_view.dart';
import 'package:go_router/go_router.dart';

abstract class AppRouter {
  static const String initialRoute = '/';
  static const String signInView = '/signInView';
  static const String signUpView = '/signUpView';
  static final router = GoRouter(routes: [
    GoRoute(
      path: signInView,
      builder: (context, state) => const SignInView(),
    ),
    GoRoute(
      path: signUpView,
      builder: (context, state) => const SignUpView(),
    ),
    GoRoute(
      path: initialRoute,
      builder: (context, state) => const SignInView(),
    ),
  ]);
}
