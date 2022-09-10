import 'package:prezent/models/models.dart';

class ClassModel {
  final Course course;
  final Branch branch;
  final int section;
  final int passingYear;
  final String classId;
  final List<StudentModel> students;

  ClassModel({
    required this.course,
    required this.branch,
    required this.section,
    required this.passingYear,
    required this.classId,
    required this.students,
  });
}

enum Course {
  btech,
  mtech,
}

enum Branch {
  cse,
  ece,
  me,
  ce,
  en,
  ei,
}
