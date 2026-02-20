import 'package:client/features/auth/view/widgets/sign_up_body.dart';
import 'package:flutter/material.dart';

class SignUpView extends StatelessWidget {
  const SignUpView({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: const SignUpBody(),
        appBar: AppBar(),
      ),
    );
  }
}
