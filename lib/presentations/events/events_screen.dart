import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:intl/intl.dart';
import 'package:todo_task/blocs/event_over_view/event_over_view_bloc.dart';
import 'package:todo_task/presentations/event_add/event_add_screen.dart';
import 'package:todo_task/presentations/events/widgets/event_item.dart';
import 'package:todo_task/presentations/global_widgets/custom_button.dart';
import 'package:todo_task/utils/colors.dart';
import 'package:todo_task/utils/icons.dart';
import 'package:todo_task/utils/time_utils.dart';
import 'package:todo_task/utils/toast_utils.dart';

import 'widgets/calendar/calendar_data.dart';
part 'widgets/calendar/calendar.dart';

class EventsScreen extends StatelessWidget {
  const EventsScreen({super.key});
  static Route<void> route() {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => const EventsScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final events =
        context.select((EventOverViewBloc bloc) => bloc.state.events);
    final status =
        context.select((EventOverViewBloc bloc) => bloc.state.status);
    return Scaffold(
      body: BlocListener<EventOverViewBloc, EventOverViewState>(
        listenWhen: (previous, current) =>
            current.status != OverviewStatus.initial &&
            current.status != OverviewStatus.loading &&
            current.status != OverviewStatus.loaded,
        listener: (context, state) => state.status == OverviewStatus.failure
            ? ToastUtils.errorToast(context, message: state.message!)
            : ToastUtils.successToast(context, message: state.message ?? ""),
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 28.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Expanded(child: CustomCalendar()),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Schedule",
                    style: TextStyle(
                      color: const Color(0xFF292929),
                      fontSize: 14.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.17,
                    ),
                  ),
                  CustomButton(
                      width: 102.w,
                      height: 30.h,
                      radiusValue: 10.r,
                      buttonText: "+ Add Event",
                      onPressed: () => Navigator.of(context).push(
                            EventAddScreen.route(),
                          ))
                ],
              ),
              status == OverviewStatus.loading
                  ? const Center(child: CircularProgressIndicator.adaptive())
                  : Expanded(
                      child: ListView(
                          children: List.generate(events.length,
                              (index) => EventItem(event: events[index]))),
                    )
            ],
          ),
        ),
      ),
    );
  }
}
