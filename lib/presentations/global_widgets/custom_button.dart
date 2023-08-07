import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/utils/colors.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    Key? key,
    required this.buttonText,
    this.width,
    this.height,
    this.color,
    required this.onPressed,
    this.textColor,
    this.fontSize,
    this.radiusValue,
  }) : super(key: key);

  final String buttonText;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final Color? color;
  final Color? textColor;
  final double? fontSize;
  final double? radiusValue;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height ?? 56,
      width: width,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: color ?? AppColors.primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(8.r),
          ),
        ),
        onPressed: onPressed,
        child: Text(
          buttonText,
          style: TextStyle(
            color: textColor ?? Colors.white,
            fontSize: fontSize ?? 10.sp,
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w600,
            letterSpacing: -0.17,
          ),
        ),
      ),
    );
  }
}
