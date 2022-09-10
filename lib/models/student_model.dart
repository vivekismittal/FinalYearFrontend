class StudentModel {
  final String name;
  final String emailId;
  final int? studentNo;
  final int rollNo;
  final int? mobileNo;
  final List<Subject> subjects;
  StudentModel({
    required this.name,
    required this.emailId,
    required this.rollNo,
    required this.subjects,
    this.mobileNo,
    this.studentNo,
  });
}

class Subject {
  final String subjectCode;
  final List<DateAttendance> attendances;

  Subject({
    required this.subjectCode,
    required this.attendances,
  });
}

class DateAttendance {
  final DateTime dateTime;
  final int attendanceCount;

  DateAttendance({
    required this.dateTime,
    required this.attendanceCount,
  });
}
