import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prezent/data/class_data.dart';
import 'package:prezent/models_2.dart/class_subject.dart';
import 'package:prezent/models_2.dart/course_branch.dart';
import 'package:prezent/requests/class_request.dart';

class ClassController extends GetxController {
  ClassRequest classRequest = ClassRequest();

  RxBool isBranchFetching = false.obs;
  RxBool isCourseFetching = false.obs;

  RxBool isCourseFailed = false.obs;
  RxBool isBranchFailed = false.obs;

  final courseBranchFormKey = GlobalKey<FormState>(debugLabel: 'Course-Branch');
  late void Function() lastFn;

  void updateCourseBranchView() {
    update(['Course-Branch-View']);
    courseBranchFormKey.currentState?.reset();
  }

  void updateClassSubjectView() {
    update(['All-Class-Subject-View']);
    classFormKey.currentState?.reset();
  }

  TextEditingController newCourse = TextEditingController();
  TextEditingController newBranch = TextEditingController();

  //COURSE

  void addNewCourse() {
    if (courseBranchFormKey.currentState!.validate()) {
      allCourses.add(
        Course(
          course: newCourse.text,
        ),
      );
      updateCourseBranchView();
    }
  }

  void removeCourse(int index) {
    allCourses.removeAt(index);
    updateCourseBranchView();
  }

  void updateCourse() async {
    isCourseFetching(true);
    isCourseFailed(false);
    bool isCourseSaved = await classRequest.postCourses(allCourses);
    if (isCourseSaved) {
      isCourseFetching(false);
    } else {
      isCourseFailed(true);
      print('ERROR SAVING COURSES');
    }
  }

  void getCourses() async {
    isCourseFetching(true);
    isCourseFailed(false);
    bool isFetchedCourses = await classRequest.fetchAllCourses();
    if (isFetchedCourses) {
      isCourseFetching(false);
      isCourseFetched = true;
    } else {
      isCourseFailed(true);
    }
  }

  //BRANCH
  void addNewBranch() {
    if (courseBranchFormKey.currentState!.validate()) {
      allBranches.add(
        Branch(
          branch: newBranch.text,
        ),
      );
      updateCourseBranchView();
    }
  }

  void removeBranch(int index) {
    allBranches.removeAt(index);
    updateCourseBranchView();
  }

  void updateBranch() async {
    isBranchFetching(true);
    isBranchFailed(false);
    bool isBranchSaved = await classRequest.postBranches(allBranches);
    print(isBranchSaved);
    if (isBranchSaved) {
      isBranchFetching(false);
    } else {
      isBranchFailed(true);
      print('ERROR SAVING BRANCHES');
    }
  }

  void getBranches() async {
    isBranchFetching(true);
    isBranchFailed(false);
    bool isFetchedBranches = await classRequest.fetchAllBranches();
    print(isFetchedBranches);
    if (isFetchedBranches) {
      isBranchFetching(false);
      isBranchFetched = true;
    } else {
      isBranchFailed(true);
    }
  }

//////CLASSES//////////
  RxBool isClassFetching = false.obs;
  RxBool isClassFailed = false.obs;
  RxBool isClassPosting = false.obs;
  RxBool isClassPostingFailed = false.obs;

  final classFormKey = GlobalKey<FormState>(debugLabel: 'All-CLasses');
  late TextEditingController courseInput;
  late TextEditingController branchInput;
  late TextEditingController sectionInput;
  late TextEditingController passingYearInput;

  void initNewClassForm() {
    courseInput = TextEditingController();
    branchInput = TextEditingController();
    sectionInput = TextEditingController();
    passingYearInput = TextEditingController();
    isClassPosting(false);
    isClassPostingFailed(false);
  }

  void getClasses() async {
    isClassFetching(true);
    isClassFailed(false);
    bool isFetchedClasses = await classRequest.fetchAllClasses();
    print(isFetchedClasses);
    if (isFetchedClasses) {
      isClassFetching(false);
      isClassFetched = true;
    } else {
      isClassFailed(true);
    }
  }

  List<String> get getClassIds {
    List<String> list = [];
    for (var class_ in allClasses) {
      list.add(class_.classId);
    }
    list.sort();
    return list;
  }

  void saveClass() async {
    isClassPosting(true);
    String newClassId =
        '${courseInput.text}-${passingYearInput.text}-${branchInput.text}-${sectionInput.text}';
    Class newClass = Class(
      branch: branchInput.text,
      course: courseInput.text,
      section: int.parse(sectionInput.text),
      passingYear: int.parse(passingYearInput.text),
      classId: newClassId,
    );
    bool isPostedClass = await classRequest.postClass(newClass);
    if (isPostedClass) {
      isClassPosting(false);
      Get.back();
      updateClassSubjectView();
    } else {
      log('ERROR SAVING Classes');
      isClassPostingFailed(true);
    }
  }

  //////SUBJECTS//////////
  RxBool isSubjectFetching = false.obs;
  RxBool isSubjectFetchingFailed = false.obs;
  RxBool isSubjectPosting = false.obs;
  RxBool isSubjectPostingFailed = false.obs;

  final subjectFormKey = GlobalKey<FormState>(debugLabel: 'All-SUBJECTS');
  late TextEditingController subjectNameInput;
  late TextEditingController subjectCodeInput;

  void initNewSubjectForm() {
    subjectNameInput = TextEditingController();
    subjectCodeInput = TextEditingController();
    isSubjectPosting(false);
    isSubjectPostingFailed(false);
  }

  void getSubjects() async {
    isSubjectFetching(true);
    isSubjectFetchingFailed(false);
    bool isFetchedSubjects = await classRequest.fetchAllSubjects();
    print(isFetchedSubjects);
    if (isFetchedSubjects) {
      isSubjectFetching(false);
    } else {
      isSubjectFetchingFailed(true);
    }
  }

List<String> get getsubjectCodes {
    List<String> list = [];
    for (var subject in allSubjects) {
      list.add(subject.subjectCode);
    }
    list.sort();
    return list;
  }

  void saveSubject() async {
    isSubjectPosting(true);
    Subject newSubject = Subject(
        subjectName: subjectNameInput.text, subjectCode: subjectCodeInput.text);
    bool isPostedSubject = await classRequest.postSubject(newSubject);
    if (isPostedSubject) {
      isSubjectPosting(false);
      Get.back();
      updateClassSubjectView();
    } else {
      log('ERROR SAVING SUBJECT');
      isSubjectPostingFailed(true);
    }
  }
}
