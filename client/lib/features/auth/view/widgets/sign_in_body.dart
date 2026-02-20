import 'package:client/core/utils/app_router.dart';
import 'package:client/core/utils/show_snack_bar.dart';
import 'package:client/features/auth/view/widgets/auth_button.dart';
import 'package:client/features/auth/view/widgets/auth_text_form_field.dart';
import 'package:client/features/auth/view/widgets/custom_text_button.dart';
import 'package:client/features/auth/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignInBody extends ConsumerStatefulWidget {
  const SignInBody({
    super.key,
  });

  @override
  ConsumerState<SignInBody> createState() => _SignInBodyState();
}

class _SignInBodyState extends ConsumerState<SignInBody> {
  late GlobalKey<FormState> formKey;
  String? email, password;
  @override
  void initState() {
    formKey = GlobalKey<FormState>();
        ref.listenManual(authViewModelProvider, (_, next) {
      next.when(
        data: (data) {
          showSnackBar(context, "Signed in successfully");
        },
        error: (error, stackTrace) => showSnackBar(
          context,
          error.toString(),
        ),
        loading: () {},
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(authViewModelProvider).isLoading;
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.only(
          left: 20.w,
          right: 20.w,
          top: 20.h,
          bottom: MediaQuery.of(context).viewInsets.bottom,
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 150.h),
              Text(
                'Sign In',
                style: TextStyle(fontSize: 50.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              AuthTextFormField(
                hintText: 'Email',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Email is required';
                  }
                  if (value.contains('@') == false) {
                    return 'Enter a valid email';
                  }
                  return null;
                },
                onSaved: (value) => email = value,
              ),
              SizedBox(height: 20.h),
              AuthTextFormField(
                hintText: 'Password',
                obscureText: true,
                onSaved: (value) => password = value,
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Password is required';
                  }
                  if (value.length < 6) {
                    return 'Password must be at least 6 characters';
                  }
                  return null;
                },
              ),
              SizedBox(height: 20.h),
              AuthButton(
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    ref
                        .read(authViewModelProvider.notifier)
                        .signIn(email: email!, password: password!);
                  }
                },
                text: 'Sign In',
                isLoading: isLoading,
              ),
              SizedBox(height: 20.h),
              CustomTextButton(
                firstText: "Don't have an account?",
                btnText: "Sign Up",
                onTap: () {
                  GoRouter.of(context).push(AppRouter.signUpView);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
