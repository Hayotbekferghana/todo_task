import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_task/data/models/event_model.dart';

import 'package:todo_task/presentations/events/event_detail_screen/event_detail_screen.dart';
import 'package:todo_task/utils/icons.dart';

class EventItem extends StatelessWidget {
  const EventItem({super.key, required this.event});
  final Event event;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(context, EventDetailScreen.route(event)),
      child: Padding(
        padding: EdgeInsets.symmetric(vertical: 7.h),
        child: SizedBox(
          width: 319.w,
          height: 95.h,
          child: Stack(
            children: [
              Positioned(
                left: 0,
                top: 0,
                child: Opacity(
                  opacity: 0.2,
                  child: Container(
                    width: 319.w,
                    height: 95.h,
                    decoration: ShapeDecoration(
                      color: Color(event.color),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                top: 0,
                child: Container(
                  width: 319.w,
                  height: 10.w,
                  decoration: ShapeDecoration(
                    color: Color(event.color),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(10.r),
                        topRight: Radius.circular(10.r),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 12.w,
                top: 22.h,
                child: _titleText(event.name, event.color),
              ),
              Positioned(
                left: 34.w,
                top: 67.h,
                child: _timeText(
                  '${event.firstDate} - ${event.secondDate}',
                  event.color,
                ),
              ),
              Visibility(
                visible: event.location.isNotEmpty,
                child: Positioned(
                  left: 124.w,
                  top: 67.h,
                  child: _timeText(event.location, event.color),
                ),
              ),
              Positioned(
                left: 12.w,
                top: 43.h,
                child:
                    _descriptionText(event.description, event.color, context),
              ),
              Positioned(
                left: 12.w,
                top: 65.h,
                child: SvgPicture.asset(
                  AppIcons.time,
                  width: 18.w,
                  height: 18.w,
                  colorFilter:
                      ColorFilter.mode(Color(event.color), BlendMode.srcIn),
                ),
              ),
              Visibility(
                visible: event.location.isNotEmpty,
                child: Positioned(
                  left: 103.w,
                  top: 66.h,
                  child: SvgPicture.asset(
                    AppIcons.location,
                    colorFilter:
                        ColorFilter.mode(Color(event.color), BlendMode.srcIn),
                    width: 18.w,
                    height: 18.w,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _titleText(String title, int colorValue) => Text(
        title,
        style: TextStyle(
          fontSize: 16.sp,
          color: Color(colorValue),
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          letterSpacing: -0.17,
        ),
      );

  _descriptionText(String text, int colorValue, BuildContext context) =>
      SizedBox(
        width: MediaQuery.sizeOf(context).width * 0.6,
        child: Text(
          text,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(
            fontSize: 8.sp,
            fontFamily: 'Poppins',
            color: Color(colorValue),
            fontWeight: FontWeight.w400,
            letterSpacing: -0.17,
          ),
        ),
      );
  _timeText(String text, int colorValue) => Text(
        text,
        style: TextStyle(
          fontSize: 10.sp,
          color: Color(colorValue),
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w500,
          letterSpacing: -0.17,
        ),
      );
}
