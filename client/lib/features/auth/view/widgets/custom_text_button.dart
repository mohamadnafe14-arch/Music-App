import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CustomTextButton extends StatelessWidget {
  const CustomTextButton({
    super.key,
    required this.firstText,
    required this.btnText,
    required this.onTap,
  });
  final String firstText, btnText;
  final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Text(
          firstText,
          style: TextStyle(fontSize: 16.sp, fontWeight: FontWeight.w500),
        ),
        TextButton(
          onPressed: onTap,
          child: Text(btnText, style: TextStyle(fontSize: 16.sp)),
        ),
      ],
    );
  }
}
