import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:prezent/models_2.dart/lecture_model.dart';
import 'package:prezent/requests/faculty_request.dart';

class FacultyController extends GetxController {
  FacultyRequest facultyRequest = FacultyRequest();

  bool isAllFacultiesFetching = false;
  bool isAllFacultiesFetchingFailed = false;
  bool isAllFacultyFetched = false;

  Map<String, bool> isFacultyLecturesFetching = {};
  Map<String, bool> isFacultyLecturesFetchingFailed = {};

  Map<String, RxBool> isFacultyLecturesAssigning = {};
  Map<String, RxBool> isFacultyLecturesAssigningFailed = {};

  void updateAllFacultiesView() {
    update(["Faculties-View"]);
  }

  void updateAllFacultiesLecturesView(String email) {
    update(['Faculty-Lecture-View-$email']);
  }

  void getAllFaculties() async {
    isAllFacultiesFetching = true;
    updateAllFacultiesView();

    isAllFacultyFetched = await facultyRequest.fetchAllFaculties();

    if (isAllFacultiesFetching) {
      isAllFacultiesFetching = false;
    } else {
      isAllFacultiesFetchingFailed = true;
    }
    updateAllFacultiesView();
  }

  void getAllLecturesByFaculty(String email) async {
    isFacultyLecturesFetching[email] = true;
    isFacultyLecturesFetchingFailed[email] = false;
    updateAllFacultiesLecturesView(email);

    bool isLecturesFetched =
        await facultyRequest.fetchAllLecturesByFaculty(email);

    if (isLecturesFetched) {
      isFacultyLecturesFetching[email] = false;
      isFacultyLecturesAssigning[email]= false.obs;
      isFacultyLecturesAssigningFailed[email] = false.obs;
    } else {
      isFacultyLecturesFetchingFailed[email] = true;
    }
    updateAllFacultiesLecturesView(email);
  }

  late TextEditingController classIdInput;
  late TextEditingController subjectCodeInput;

  void initAssignLectureForm(String email) {
     isFacultyLecturesAssigning[email] = false.obs;
      isFacultyLecturesAssigningFailed[email] = false.obs;
    classIdInput = TextEditingController();
    subjectCodeInput = TextEditingController();
  }

  void assignLecture(String email) async {
    isFacultyLecturesAssigning[email] = true.obs;
    isFacultyLecturesAssigningFailed[email] = false.obs;

    updateAllFacultiesLecturesView(email);

    bool isLectureAssigned = await facultyRequest.assignFacultyLecture(
      Lecture(
        email: email,
        classId: classIdInput.text,
        subjectCode: subjectCodeInput.text,
      ),
    );

    if (isLectureAssigned) {
      isFacultyLecturesAssigning[email] = false.obs;
      Get.back();
    } else {
      isFacultyLecturesAssigningFailed[email] = true.obs;
    }

    updateAllFacultiesLecturesView(email);
  }
}
