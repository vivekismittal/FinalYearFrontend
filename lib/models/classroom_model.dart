import 'package:prezent/models/models.dart';

class ClassRoomModel {
  final ClassSubjectIdModel classSubjectId;
  final List<TimeWiseAttendanceModel> timeWiseAttendanceList;

  ClassRoomModel({
    required this.classSubjectId,
    required this.timeWiseAttendanceList,
  });
}

class TimeWiseAttendanceModel {
  final DateTime startedat;
  final int durationInMin;
  final List<StudentAttendanceModel> studentAttendanceList;

  TimeWiseAttendanceModel({
    required this.startedat,
    required this.durationInMin,
    required this.studentAttendanceList,
  });
}

class StudentAttendanceModel {
  final int rollNo;
  final bool isPresent;

  StudentAttendanceModel({
    required this.rollNo,
    required this.isPresent,
  });
}

