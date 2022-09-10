import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prezent/models/models.dart';
import 'package:prezent/modules/faculty/pages/class-detail/controller/class_detail_view_conroller.dart';
import 'package:table_calendar/table_calendar.dart';

class AttendanceCalender extends StatefulWidget {
  const AttendanceCalender({
    super.key,
    required this.classSubjectId,
    required this.viewController,
  });
  final ClassSubjectIdModel classSubjectId;
  final ClassDetailViewController viewController;
  @override
  State<AttendanceCalender> createState() => _AttendanceCalenderState();
}

class _AttendanceCalenderState extends State<AttendanceCalender> {
  RxInt todayDate = 23.obs;

  late CalendarFormat _calendarFormat;
  late DateTime _focusedDay;
  @override
  void initState() {
    _focusedDay = DateTime.now();
    _calendarFormat = CalendarFormat.week;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Get.theme.colorScheme;
    return TableCalendar(
      rowHeight: 40,
      focusedDay: _focusedDay,
      lastDay: DateTime.now(),
      firstDay: DateTime.now().subtract(
        const Duration(
          days: 365,
        ),
      ),
      onDaySelected: (selectedDay, focusedDay) {
        widget.viewController
            .updateAttendance(selectedDay, widget.classSubjectId);
        setState(() {
          widget.viewController.selectedDate = selectedDay;
          _focusedDay = focusedDay; // update `_focusedDay` here as well
        });
      },
      calendarFormat: _calendarFormat,
      onFormatChanged: (format) {
        setState(() {
          _calendarFormat = format;
        });
      },
      selectedDayPredicate: (day) {
        return isSameDay(widget.viewController.selectedDate, day);
      },
      holidayPredicate: (day) {
        if (day.weekday == DateTime.sunday) return true;
        return !widget.viewController.isWorkingDay(day, widget.classSubjectId);
      },
      calendarStyle: CalendarStyle(
        holidayDecoration: BoxDecoration(
          color: colorScheme.error.withOpacity(.5),
          border: Border.fromBorderSide(
            BorderSide(
              color: colorScheme.onError,
              width: 1.4,
            ),
          ),
          shape: BoxShape.circle,
        ),
        holidayTextStyle: TextStyle(
          color: colorScheme.onError,
        ),
      ),
      calendarBuilders: CalendarBuilders(
        dowBuilder: (context, day) {
          List week = [
            'Mon',
            'Tue',
            'Wed',
            'Thu',
            'Fri',
            'Sat',
            'Sun',
          ];
          return Center(
            child: Text(
              week[day.weekday - 1],
              style: TextStyle(
                color: day.weekday == DateTime.sunday
                    ? colorScheme.error
                    : colorScheme.secondary,
                fontSize: 16,
              ),
            ),
          );
        },
      ),
    );
  }

//   Padding x(Map<String, int> dayDate) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Row(
//         mainAxisAlignment: MainAxisAlignment.spaceBetween,
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: List.generate(
//           7,
//           (index) => Obx(
//             () => dayWidget(
//               day: dayDate.keys.toList()[index],
//               date: dayDate.values.toList()[index],
//               isToday: todayDate.value == dayDate.values.toList()[index],
//             ),
//           ),
//         ),
//       ),
//     );
//   }

//   Column dayWidget({
//     required String day,
//     required int date,
//     bool isToday = false,
//   }) {
//     ColorScheme colorScheme = Get.theme.colorScheme;
//     return Column(
//       children: [
//         Text(
//           day,
//           style: Get.theme.textTheme.bodySmall?.copyWith(
//             fontSize: 16,
//             color: isToday ? colorScheme.primary : colorScheme.onBackground,
//           ),
//         ),
//         GestureDetector(
//           onTap: () => todayDate(date),
//           child: CircleAvatar(
//             radius: 18,
//             backgroundColor: isToday
//                 ? colorScheme.primary.withOpacity(.5)
//                 : colorScheme.background,
//             foregroundColor: colorScheme.onBackground,
//             child: Text('$date'),
//           ),
//         ),
//         Visibility(
//           visible: isToday,
//           child: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               Icon(
//                 Icons.arrow_drop_up_outlined,
//                 color: colorScheme.error,
//               ),
//               Text(
//                 'Today',
//                 style: Get.theme.textTheme.bodySmall?.copyWith(
//                   color: colorScheme.error,
//                 ),
//               )
//             ],
//           ),
//         ),
//       ],
//     );
//   }
}
