import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/utils/colors.dart';

class DescriptionTextField extends StatelessWidget {
  const DescriptionTextField(
      {super.key, this.initialValue, required this.onChanged});
  final String? initialValue;
  final ValueChanged<String> onChanged;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Event description",
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
          height: 134.h,
          decoration: BoxDecoration(
            color: AppColors.inputColor,
            borderRadius: BorderRadius.circular(8.r),
          ),
          child: TextFormField(
            initialValue: initialValue,
            decoration: InputDecoration(
                contentPadding: EdgeInsets.all(5.w),
                enabledBorder: InputBorder.none,
                focusedBorder: InputBorder.none),
            // maxLength: 300,
            maxLines: 7,
            inputFormatters: [
              LengthLimitingTextInputFormatter(300),
            ],
            onChanged: onChanged,
          ),
        ),
      ],
    );
  }
}
