import 'dart:developer';

import 'package:get/get.dart';
import 'package:prezent/models/dummy_data.dart';
import 'package:prezent/models/models.dart';
import 'package:table_calendar/table_calendar.dart';

class ClassDetailViewController extends GetxController {
  bool isRecordAvailable = false;
  late ClassSubjectIdModel classSubjectId;
  DateTime selectedDate = DateTime.now();
  bool isToday = true;
  List<DateTime> attendanceDates(ClassSubjectIdModel classSubjectId) {
    List<TimeWiseAttendanceModel> timeWiseAttendanceList = dummyListOfClassRoom
        .where((classRoom) => classRoom.classSubjectId == classSubjectId)
        .first
        .timeWiseAttendanceList;
    return List.generate(timeWiseAttendanceList.length,
        (index) => timeWiseAttendanceList[index].startedat);
  }

  bool isWorkingDay(DateTime day, ClassSubjectIdModel classSubjectId) {
    List<DateTime> attendenceDays = attendanceDates(classSubjectId);
    for (var e in attendenceDays) {
      if (isSameDay(e, day)) {
        return true;
      }
    }

    return false;
  }

  void updateAttendance(DateTime day, ClassSubjectIdModel classSubjectId) {
    isToday = isSameDay(day, DateTime.now());
    isRecordAvailable = isWorkingDay(day, classSubjectId);
    update(['ClassDetailView-$classSubjectId']);
  }

  int get totalNoOfStudent {
    return dummyClasses
        .where((element) => element.classId == classSubjectId.classId)
        .first
        .students
        .length;
  }

  List<TimeWiseAttendanceModel> timeSlots() {
    return dummyFaculty.classRooms
        .where((el) => el.classSubjectId == classSubjectId)
        .first
        .timeWiseAttendanceList
        .where(
          (el) => isSameDay(el.startedat, selectedDate),
        )
        .toList();
  }

  List<StudentAttendanceModel> studentList(bool forPresent, int index) {
    List<StudentAttendanceModel> totalStudentsList =
        timeSlots()[index].studentAttendanceList;
    return totalStudentsList.where((el) => el.isPresent == forPresent).toList();
  }

  String getTimeSlot(int index) {
    TimeWiseAttendanceModel timeWiseAttendance = timeSlots()[index];
    int startingTimeHour = timeWiseAttendance.startedat.hour;
    int startingTimeMin = timeWiseAttendance.startedat.minute;
    int durationHour = timeWiseAttendance.durationInMin ~/ 60;
    int durationMin = timeWiseAttendance.durationInMin - durationHour * 60;
    return '$startingTimeHour:$startingTimeMin - ${startingTimeHour + durationHour}:${startingTimeMin + durationMin}';
  }

  void updateWrappedTimeSlots() {
    update(['Wrapped-timeSlots']);
  }
}
