import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prezent/data/user_data.dart';
import 'package:prezent/models_2.dart/student_model.dart';
import 'package:prezent/requests/student_request.dart';

class StudentController extends GetxController {
  StudentRequest studentRequest = StudentRequest();
  GlobalKey registrationFormKey =
      GlobalKey<FormState>(debugLabel: 'student-registration');

  TextEditingController rollNoInput = TextEditingController();
  TextEditingController studentNoInput = TextEditingController();
  TextEditingController classIdInput = TextEditingController();

  RxBool isStudentRegistering = false.obs;
  RxBool isStudentRegisteringFailed = false.obs;

  void initStudentRegisterForm() {
    rollNoInput = TextEditingController();
    studentNoInput = TextEditingController();
    classIdInput = TextEditingController();

    isStudentRegistering = false.obs;
    isStudentRegisteringFailed = false.obs;
  }

  void register() async {
    isStudentRegistering(true);
    Student studentToBeRegister = Student(
      email: activeUser.email,
      classId: classIdInput.text,
      rollNo: int.parse(rollNoInput.text),
      studentNo: int.parse(studentNoInput.text),
    );

    bool isRegistered =
        await studentRequest.registerStudent(studentToBeRegister);
    if (isRegistered) {
      isStudentRegistering(false);
      activeUser.isRegistered = true;
      updateStudentView();
      Get.back();
      print('Student Registeresd');
    } else {
      log('ERROR Registering Student');
      isStudentRegisteringFailed(true);
    }
  }

  bool isStudentFetching = false;
  bool isStudentFetchingFailed = false;

  void getStudent() async {
    isStudentFetching = true;
    bool isStudentFetched = await studentRequest.fetchStudent();
    if (isStudentFetched) {
      isStudentFetching = false;
    } else {
      isStudentFetchingFailed = true;
    }
    updateStudentView();
  }

  bool isStudentSubjectsFetching = false;
  bool isStudentSubjectsFetchingFailed = false;

  void getStudentSubjects() async {
    isStudentSubjectsFetching = true;
    bool isStudentSubjectsFetched = await studentRequest.fetchStudentSubjects();
    if (isStudentSubjectsFetched) {
      isStudentSubjectsFetching = false;
    } else {
      isStudentSubjectsFetchingFailed = true;
    }
    updateStudentLectureView();
  }


  void selectSubject(bool isSelected, String subjectCode,List<String> studentSubjectsList) {
    if (isSelected) {
      studentSubjectsList.add(subjectCode);
    } else {
      studentSubjectsList.remove(subjectCode);
    }
    updateStudentLectureView();
  }

  bool isStudentSubjectsSaving = false;
  bool isStudentSubjectsSavingFailed = false;

  void saveStudentSubjects(List<String> studentSubjectsList) async {
    isStudentSubjectsSaving = true;
    bool isStudentSubjectsSaved =
        await studentRequest.postStudentSubjects(studentSubjectsList);
    if (isStudentSubjectsSaved) {
      isStudentSubjectsSaving = false;
      Get.back();
    } else {
      isStudentSubjectsSavingFailed = true;
    }
    updateStudentLectureView();
  }

  void updateStudentView() {
    update(['Student-View']);
  }

  void updateStudentLectureView() {
    update(['Added-Lectures-View']);
  }
}
