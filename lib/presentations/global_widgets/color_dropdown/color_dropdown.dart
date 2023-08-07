import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_task/utils/colors.dart';
import 'package:todo_task/utils/icons.dart';

class ColorDropdown extends StatelessWidget {
  ColorDropdown({super.key, required this.onChanged, this.color});
  final List<int> colors = [0xFF009FEE, 0xFF3EA055, 0xFF673AB7, 0xFFEE2A00];
  final int? color;
  final ValueChanged<int?>? onChanged;
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Priority color ",
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
          width: color != null ? 75.w : 100.w,
          height: 32.h,
          decoration: ShapeDecoration(
            color: AppColors.inputColor,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8.r)),
          ),
          child: Center(
            child: DropdownButton<int>(
              padding: EdgeInsets.all(5.w),
              borderRadius: BorderRadius.circular(8.r),
              value: color,
              icon: SvgPicture.asset(
                AppIcons.down,
                width: 24.w,
                height: 24.w,
              ),
              hint: const Text(
                "Color",
                textAlign: TextAlign.center,
              ),
              // padding: const EdgeInsets.only(left: 10),
              isExpanded: true,
              isDense: true,
              underline: const SizedBox.shrink(),
              items: colors
                  .map((value) => DropdownMenuItem(
                      value: value,
                      child: Container(
                        // width: 23,
                        height: 20.h,
                        decoration: BoxDecoration(
                            color: Color(value),
                            borderRadius: BorderRadius.circular(3.r)),
                      )))
                  .toList(),
              onChanged: onChanged,
            ),
          ),
        ),
      ],
    );
  }
}
