import 'package:client/core/theme/app_palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class AuthButton extends StatelessWidget {
  const AuthButton({
    super.key,
    required this.onPressed,
    required this.text,
    required this.isLoading,
  });
  final VoidCallback onPressed;
  final String text;
  final bool isLoading;
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [AppPalette.gradient1, AppPalette.gradient2],
          begin: Alignment.bottomLeft,
          end: Alignment.topRight,
        ),
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          fixedSize: Size(300.w, 50.h),
        ),
        onPressed: onPressed,
        child: isLoading
            ? const CircularProgressIndicator()
            : Text(
                text,
                style: TextStyle(fontSize: 20.sp, fontWeight: FontWeight.w500),
              ),
      ),
    );
  }
}
