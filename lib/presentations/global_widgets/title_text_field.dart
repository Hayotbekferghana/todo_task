import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_task/utils/colors.dart';
import 'package:todo_task/utils/icons.dart';

class TitleTextField extends StatelessWidget {
  const TitleTextField(
      {super.key,
      this.hint,
      this.onChanged,
      this.initialValue,
      this.onIconTap,
      this.isTitle = true});

  final String? hint;
  final ValueChanged<String>? onChanged;
  final VoidCallback? onIconTap;
  final String? initialValue;
  final bool isTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          isTitle ? "Event name" : "Event location",
          style: TextStyle(
            color: AppColors.inputTitleColor,
            fontSize: 14.sp,
            fontFamily: 'Roboto',
            fontWeight: FontWeight.w400,
            height: 1.43,
            letterSpacing: 0.25,
          ),
        ),
        Container(
          width: 328.w,
          height: 42.h,
          decoration: BoxDecoration(
            color: AppColors.inputColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: Center(
            child: TextFormField(
              initialValue: initialValue,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.text,
              onChanged: onChanged,
              decoration: InputDecoration(
                  suffixIcon: isTitle
                      ? const SizedBox()
                      : GestureDetector(
                          onTap: onIconTap,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              AppIcons.inputLocation,
                              width: 10.h,
                              height: 10.h,
                            ),
                          ),
                        ),
                  contentPadding: EdgeInsets.all(5.w),
                  hintText: hint,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none),
            ),
          ),
        ),
      ],
    );
  }
}
