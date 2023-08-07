import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:todo_task/blocs/event_add/event_add_bloc.dart';
import 'package:todo_task/data/models/event_model.dart';
import 'package:todo_task/presentations/events/events_screen.dart';
import 'package:todo_task/presentations/global_widgets/color_dropdown/color_dropdown.dart';
import 'package:todo_task/presentations/global_widgets/custom_button.dart';
import 'package:todo_task/presentations/global_widgets/date_button.dart';
import 'package:todo_task/presentations/global_widgets/description_text_field.dart';
import 'package:todo_task/presentations/global_widgets/title_text_field.dart';
import 'package:todo_task/utils/colors.dart';

import 'package:todo_task/utils/time_utils.dart';

class EventEditScreen extends StatelessWidget {
  const EventEditScreen({super.key});

  static Route<void> route(Event event) {
    return MaterialPageRoute(
      fullscreenDialog: true,
      builder: (context) => BlocProvider(
        create: (context) => EventAddBloc(event: event),
        child: const EventEditScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<EventAddBloc, EventAddState>(
      listenWhen: (previous, current) => current.status == AddingStatus.edited,
      listener: (context, state) =>
          Navigator.pushReplacement(context, EventsScreen.route()),
      child: const EventEditView(),
    );
  }
}

class EventEditView extends StatelessWidget {
  const EventEditView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 14.w),
        child: const Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            _TitleTextField(),
            _DescriptionTextField(),
            _LocationTextField(),
            _SelectColor(),
            _SelectDateTime(),
            _SubmitButton()
          ],
        ),
      ),
    );
  }
}

class _TitleTextField extends StatelessWidget {
  const _TitleTextField();

  @override
  Widget build(BuildContext context) {
    final name = context.select((EventAddBloc bloc) => bloc.state.name);
    return TitleTextField(
      initialValue: name,
      onChanged: (value) {
        context.read<EventAddBloc>().add(EventNameChanged(name: value));
      },
    );
  }
}

class _DescriptionTextField extends StatelessWidget {
  const _DescriptionTextField();

  @override
  Widget build(BuildContext context) {
    final description =
        context.select((EventAddBloc bloc) => bloc.state.description);

    return DescriptionTextField(
      initialValue: description,
      onChanged: (value) {
        context
            .read<EventAddBloc>()
            .add(EventDescriptionChanged(description: value));
      },
    );
  }
}

class _LocationTextField extends StatelessWidget {
  const _LocationTextField();

  @override
  Widget build(BuildContext context) {
    final location = context.select((EventAddBloc bloc) => bloc.state.location);

    return TitleTextField(
      initialValue: location,
      isTitle: false,
      onChanged: (value) {
        context
            .read<EventAddBloc>()
            .add(EventLocationSelected(location: value));
      },
    );
  }
}

class _SelectColor extends StatelessWidget {
  const _SelectColor();

  @override
  Widget build(BuildContext context) {
    final color = context.select((EventAddBloc bloc) => bloc.state.color);
    return ColorDropdown(
      color: color,
      onChanged: (value) {
        context.read<EventAddBloc>().add(ColorSelected(color: value!));
      },
    );
  }
}

class _SelectDateTime extends StatelessWidget {
  const _SelectDateTime();

  @override
  Widget build(BuildContext context) {
    final date =
        context.select((EventAddBloc bloc) => bloc.state.dateForScreen);
    return SelectDateTimeButton(
      selectedDate: formatDate(date!),
      onPressed: () async {
        await DateTimeUtils.getDateTime(context: context).then((value) {
          context.read<EventAddBloc>().add(
                EventTimeSelected(
                  dateForScreen: value["date"] ?? "",
                  first: value["firstTime"] ?? "",
                  second: value["secondTime"] ?? "",
                  day: value["day"] ?? "",
                ),
              );
        });
      },
    );
  }
}

class _SubmitButton extends StatelessWidget {
  const _SubmitButton();

  @override
  Widget build(BuildContext context) {
    final state = context.select((EventAddBloc bloc) => bloc.state);
    return CustomButton(
      width: 328.w,
      height: 46.h,
      fontSize: 16.sp,
      color: state.isComplete
          ? AppColors.primaryColor
          : AppColors.primaryColor.withOpacity(0.3),
      buttonText: "Edit",
      onPressed: () {
        context
            .read<EventAddBloc>()
            .add(EventSubmitted(context: context, isEdited: true));
      },
    );
  }
}
