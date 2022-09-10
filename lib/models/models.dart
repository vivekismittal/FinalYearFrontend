export 'class_model.dart';
export 'classroom_model.dart';
export 'faculty_model.dart';
export 'student_model.dart';
class ClassSubjectIdModel {
  final String classId;
  final String subjectCode;
  final int noOfStudent;
  ClassSubjectIdModel({
    required this.classId,
    required this.noOfStudent,
    required this.subjectCode,
  });
}