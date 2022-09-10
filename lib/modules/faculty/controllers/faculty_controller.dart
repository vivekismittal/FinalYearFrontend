import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:prezent/models/classroom_model.dart';
import 'package:prezent/models/dummy_data.dart';
import 'package:prezent/models/models.dart';
import 'package:prezent/modules/faculty/controllers/home_view_controller.dart';
import 'package:prezent/modules/faculty/controllers/student_controller.dart';

class FacultyController {
  TextEditingController subjectCodeController = TextEditingController();
  TextEditingController classIdController = TextEditingController();

  void addNewFacultyClass(
    HomeViewController homeViewController,
    TextEditingController subjectCodeController,
    TextEditingController classIdController,
  ) {
    String classId = classIdController.text;
    String subjectCode = subjectCodeController.text;
    log('$classId  $subjectCode');
    ClassSubjectIdModel newClassSubjectId = ClassSubjectIdModel(
        classId: classId,
        subjectCode: subjectCode,
        noOfStudent: StudentController().getNoOfStudentByClassId(classId),
        );
    dummyFaculty.classRooms.add(
      ClassRoomModel(
        classSubjectId: newClassSubjectId,
        timeWiseAttendanceList: [],
      ),
    );
    homeViewController.updateHomeView();
  }
}
