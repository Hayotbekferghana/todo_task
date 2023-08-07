part of '../../events_screen.dart';

Text weekText(String text) => Text(
      text,
      style: TextStyle(
        color: AppColors.greyTextColor,
        fontSize: 12.sp,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        letterSpacing: -0.17,
      ),
    );
Text dayText(String text, Color? color) => Text(
      text,
      style: TextStyle(
        color: color ?? AppColors.greyTextColor,
        fontSize: 12.sp,
        fontFamily: 'Poppins',
        fontWeight: FontWeight.w500,
        letterSpacing: -0.17,
      ),
    );

class CustomCalendar extends StatefulWidget {
  const CustomCalendar({super.key});

  @override
  State<CustomCalendar> createState() => _CustomCalendarState();
}

class _CustomCalendarState extends State<CustomCalendar> {
  late DateTime selectedMonth;

  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    selectedMonth = DateTime.now().monthStart;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: SizedBox(
          height: 325.h,
          width: 319.w,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              _SelectedDate(
                selectedMonth: selectedMonth,
                selectedDate: selectedDate,
                onChange: (value) => setState(() => selectedMonth = value),
              ),
              Expanded(
                child: _WeekAndDays(
                  selectedDate: selectedDate,
                  selectedMonth: selectedMonth,
                  selectDate: (DateTime value) => setState(() {
                    selectedDate = value;
                    context
                        .read<EventOverViewBloc>()
                        .add(EventsLoaded(date: selectedDate));
                  }),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _WeekAndDays extends StatelessWidget {
  const _WeekAndDays({
    required this.selectedMonth,
    required this.selectedDate,
    required this.selectDate,
  });

  final DateTime selectedMonth;
  final DateTime? selectedDate;

  final ValueChanged<DateTime> selectDate;

  @override
  Widget build(BuildContext context) {
    var data = CalendarMonthData(
      year: selectedMonth.year,
      month: selectedMonth.month,
    );

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            weekText('Mon'),
            weekText('Tue'),
            weekText('Wed'),
            weekText('Thu'),
            weekText('Fri'),
            weekText('Sat'),
            weekText('Sun'),
          ],
        ),
        const SizedBox(height: 10),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            data.weeks.length,
            (index) => Row(
              children: data.weeks[index].map((d) {
                return Expanded(
                  child: _DayItem(
                    date: d.date,
                    isActiveMonth: d.isActiveMonth,
                    onTap: () => selectDate(d.date),
                    isSelected: selectedDate != null &&
                        selectedDate!.isSameDate(d.date),
                  ),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }
}

class _DayItem extends StatelessWidget {
  const _DayItem({
    required this.isActiveMonth,
    required this.isSelected,
    required this.date,
    required this.onTap,
  });

  final bool isActiveMonth;
  final VoidCallback onTap;
  final bool isSelected;

  final DateTime date;
  @override
  Widget build(BuildContext context) {
    final allEvents =
        context.select((EventOverViewBloc bloc) => bloc.state.allEvents);
    final events = allEvents
        .where((element) => element.day == date.toIso8601String())
        .toList();
    final int number = date.day;
    final isToday = date.isToday;
    final bool isPassed = date.isBefore(DateTime.now());

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            height: 35,
            decoration: isSelected
                ? const BoxDecoration(
                    color: AppColors.primaryColor, shape: BoxShape.circle)
                : isToday
                    ? BoxDecoration(
                        borderRadius: BorderRadius.circular(35),
                      )
                    : null,
            child: dayText(
                number.toString(),
                isSelected
                    ? AppColors.white
                    : isPassed
                        ? isActiveMonth
                            ? Colors.grey
                            : Colors.transparent
                        : isActiveMonth
                            ? Colors.black
                            : Colors.grey[300]),
          ),
          SizedBox(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                  events.length >= 3 ? 3 : events.length,
                  (index) => Padding(
                        padding: EdgeInsets.symmetric(horizontal: 1.w),
                        child: CircleAvatar(
                          radius: 1.5.r,
                          backgroundColor: Color(events[index].color),
                        ),
                      )),
            ),
          )
        ],
      ),
    );
  }
}

class _SelectedDate extends StatelessWidget {
  const _SelectedDate({
    required this.selectedMonth,
    required this.selectedDate,
    required this.onChange,
  });

  final DateTime selectedMonth;
  final DateTime? selectedDate;

  final ValueChanged<DateTime> onChange;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 8.h),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              const Expanded(child: SizedBox()),
              Column(
                children: [
                  Text(
                    DateFormat('EEEE').format(selectedDate!),
                    style: TextStyle(
                      color: const Color(0xFF292929),
                      fontSize: 14.sp,
                      fontFamily: 'Poppins',
                      fontWeight: FontWeight.w600,
                      letterSpacing: -0.17,
                    ),
                  ),
                  Text(DateFormat.yMMMMd().format(selectedDate!)),
                ],
              ),
              const Expanded(child: SizedBox()),
              SvgPicture.asset(AppIcons.notification,width: 28.w,height: 28.w,)
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                DateFormat.MMMM().format(selectedMonth),
                textAlign: TextAlign.center,
              ),
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: AppColors.iconBackColor,
                    maxRadius: 20.w,
                    child: IconButton(
                        onPressed: () {
                          onChange(selectedMonth.addMonth(-1));
                        },
                        icon: Icon(
                          Icons.arrow_back_ios_sharp,
                          color: AppColors.black,
                          size: 15.w,
                        )),
                  ),
                  SizedBox(width: 2.w),
                  CircleAvatar(
                    backgroundColor: AppColors.iconBackColor,
                    maxRadius: 20.w,
                    child: IconButton(
                        onPressed: () {
                          onChange(selectedMonth.addMonth(1));
                        },
                        icon: Icon(
                          Icons.arrow_forward_ios_sharp,
                          color: AppColors.black,
                          size: 15.w,
                        )),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}
