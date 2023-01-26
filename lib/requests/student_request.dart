import 'dart:convert';
import 'dart:developer';
import 'dart:html';

import 'package:prezent/utils/app_urls.dart';
import 'package:prezent/data/student_data.dart';
import 'package:prezent/models_2.dart/student_model.dart';
import 'package:prezent/requests/request.dart';

import '../data/user_data.dart';

class StudentRequest {
  AppRequest request = AppRequest();

  ////REGISTER STUDENT////////
  Future<bool> registerStudent(Student studentToBeRegister) async {
    var result = await request.postRequest(StudentUrls.registerStudent,
        studentToBeRegister.toJson(), activeUser.email);
    if (result != null) {
      registeredStudent = Student.fromJson(result['result']);
      print('Student Registered!');
      return true;
    }
    print('Error Registering Student!!');
    return false;
  }

  Future<bool> fetchStudent() async {
    try {
      var result = await request
          .getRequest(StudentUrls.getStudent, {"email": activeUser.email});
      if (result != null) {
        registeredStudent = Student.fromJson(result["result"]['student']);
        return true;
      }
      log('Error fetching Student Detail');
      return false;
    } catch (e) {
      log('$e');
      return false;
    }
  }

  Future<bool> fetchStudentSubjects() async {
    return true;
  }

  Future<bool> postStudentSubjects(List<String> subjectCodeList) async {
    try {
      var result = await request.postRequest(StudentUrls.saveStudentSubjects,
          {"subjects": subjectCodeList}, activeUser.email);
      if (result != null) {
        registeredStudent?.subjectsCode =
            jsonDecode(result["result"]['student']);
        return true;
      }
      log('Error assinging subjects');
      return false;
    } catch (e) {
      return false;
    }
  }
}
