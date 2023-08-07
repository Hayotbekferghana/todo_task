import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_task/blocs/event_over_view/event_over_view_bloc.dart';
import 'package:todo_task/data/models/event_model.dart';
import 'package:todo_task/presentations/event_edit/event_edit_screen.dart';
import 'package:todo_task/presentations/events/events_screen.dart';
import 'package:todo_task/utils/colors.dart';
import 'package:todo_task/utils/icons.dart';
part 'widgets/app_bar.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen({super.key, required this.event});
  final Event event;
  static Route<void> route(Event event) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocListener<EventOverViewBloc, EventOverViewState>(
        listenWhen: (previous, current) =>
            current.status == OverviewStatus.deleted,
        listener: (context, state) =>
            Navigator.pushReplacement(context, EventsScreen.route()),
        child: EventDetailScreen(event: event),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          _SliverAppBar(event),
          SliverList(
            delegate: SliverChildListDelegate.fixed([
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                width: 317.w,
                height: 109.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Reminder',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.17,
                      ),
                    ),
                    SizedBox(
                      width: 317.w,
                      height: 40.h,
                      child: Text(
                        differenceDate(),
                        maxLines: 10,
                        style: TextStyle(
                          color: AppColors.greyTextColor,
                          fontSize: 14.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 20.h),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                width: 317.w,
                height: 109.h,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Description',
                      style: TextStyle(
                        color: AppColors.black,
                        fontSize: 16.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.17,
                      ),
                    ),
                    SizedBox(
                      width: 317.w,
                      height: 40.h,
                      child: Text(
                        event.description,
                        maxLines: 10,
                        style: TextStyle(
                          color: AppColors.greyTextColor,
                          fontSize: 14.sp,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w400,
                          letterSpacing: -0.17,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(height: 150.h),
              Padding(
                padding: EdgeInsets.symmetric(horizontal: 30.w),
                child: TextButton.icon(
                    style: TextButton.styleFrom(
                        fixedSize: Size(317.w, 54.h),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10.r)),
                        backgroundColor: AppColors.deleteButtonColor),
                    onPressed: () {
                      context
                          .read<EventOverViewBloc>()
                          .add(EventDeleted(event: event));
                    },
                    icon: SvgPicture.asset(AppIcons.delete),
                    label: Text(
                      "Delete Event",
                      style: TextStyle(
                        color: AppColors.inputTitleColor,
                        fontSize: 14.sp,
                        fontFamily: 'Poppins',
                        fontWeight: FontWeight.w600,
                        letterSpacing: -0.17,
                      ),
                    )),
              )
            ]),
          ),
        ],
      ),
    );
  }

  String differenceDate() {
    int difference = daysBetween(
        DateTime.parse("${event.day.split("T").first} ${event.firstDate}"),
        DateTime.now());
    return difference > 0
        ? "$difference minutes after"
        : difference == 0
            ? "0 minutes"
            : "${difference * -1} minutes before";
  }
}

int daysBetween(DateTime from, DateTime to) {
  from = DateTime(from.year, from.month, from.day, from.hour, from.minute);
  to = DateTime(to.year, to.month, to.day, to.hour, to.minute);
  return (from.difference(to).inMinutes).round();
}
