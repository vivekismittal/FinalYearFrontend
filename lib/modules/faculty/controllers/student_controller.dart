import 'package:prezent/models/dummy_data.dart';

class StudentController {
  String getStudentNameByrollNoclassId(int rollNo, String classId) =>
      dummyClasses
          .where((classEl) => classEl.classId == classId)
          .first
          .students
          .where((student) => student.rollNo == rollNo)
          .first
          .name;

  int getNoOfStudentByClassId(String classId) =>
      dummyClasses.where((cl) => cl.classId == classId).first.students.length;
}
