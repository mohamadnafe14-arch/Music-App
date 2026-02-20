import 'package:client/core/utils/show_snack_bar.dart';
import 'package:client/features/auth/view/widgets/auth_button.dart';
import 'package:client/features/auth/view/widgets/auth_text_form_field.dart';
import 'package:client/features/auth/view/widgets/custom_text_button.dart';
import 'package:client/features/auth/viewmodel/auth_view_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignUpBody extends ConsumerStatefulWidget {
  const SignUpBody({
    super.key,
  });
  @override
  ConsumerState<SignUpBody> createState() => _SignUpBodyState();
}

class _SignUpBodyState extends ConsumerState<SignUpBody> {
  late GlobalKey<FormState> formKey = GlobalKey<FormState>();
  String? name, email, password;
  @override
  void initState() {
    super.initState();
    ref.listen(authViewModelProvider, (_, next) {
      next.when(
        data: (data) {
          showSnackBar(context, "Signed up successfully");
        },
        error: (error, stackTrace) => showSnackBar(
          context,
          error.toString(),
        ),
        loading: () {},
      );
    });
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
              SizedBox(height: 100.h),
              Text(
                'Sign Up',
                style: TextStyle(fontSize: 50.sp, fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 20.h),
              AuthTextFormField(
                hintText: 'Name',
                validator: (value) {
                  if (value!.isEmpty) {
                    return 'Name is required';
                  }
                  return null;
                },
                onSaved: (value) {
                  name = value;
                },
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
                    ref.read(authViewModelProvider.notifier).signUp(
                        email: email!, password: password!, name: name!);
                  }
                },
                text: 'Sign Up',
                isLoading: isLoading,
              ),
              SizedBox(height: 20.h),
              CustomTextButton(
                firstText: "Already have an account?",
                btnText: "Sign In",
                onTap: () {
                  GoRouter.of(context).pop();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
