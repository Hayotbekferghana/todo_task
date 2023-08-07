import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/utils/colors.dart';

class SelectDateTimeButton extends StatelessWidget {
  const SelectDateTimeButton(
      {super.key, required this.onPressed, this.selectedDate});
  final VoidCallback onPressed;
  final String? selectedDate;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text("Event time",
            style: TextStyle(
              color: AppColors.inputTitleColor,
              fontSize: 14.sp,
              fontFamily: 'Roboto',
              fontWeight: FontWeight.w400,
              height: 1.43,
            )),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            maximumSize: Size(328.w, 42.h),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(8.r),
            ),
            elevation: 0,
            backgroundColor: AppColors.inputColor,
          ),
          onPressed: onPressed,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                  // width: width ?? MediaQuery.of(context).size.width * 0.4,
                  child: Text(selectedDate ?? "Select time",
                      style: TextStyle(
                        color: AppColors.inputTitleColor,
                        fontSize: 14.sp,
                        fontFamily: 'Roboto',
                        fontWeight: FontWeight.w400,
                        height: 1.43,
                      ))),
              SizedBox(
                  child:
                      Icon(Icons.keyboard_arrow_down, color: AppColors.black))
            ],
          ),
        ),
      ],
    );
  }
}
