import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prezent/data/class_data.dart';
import 'package:prezent/models_2.dart/course_branch.dart';
import 'package:prezent/requests/class_request.dart';

class ClassController extends GetxController {
  ClassRequest classRequest = ClassRequest();

  RxBool isCourseBranchFetching = false.obs;
  RxBool isClassFetching = false.obs;
  RxBool isCourseBranchFailed = false.obs;
  RxBool isClassFailed = false.obs;
  final courseBranchFormKey = GlobalKey<FormState>(debugLabel: 'Course-Branch');
  final classFormKey = GlobalKey<FormState>(debugLabel: 'All-CLasses');

  void updateCourseBranchView() {
    update(['Course-Branch-View']);
    courseBranchFormKey.currentState?.reset();
  }

  late void Function() lastFn;
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
    isCourseBranchFetching(true);
    isCourseBranchFailed(false);
    bool isCourseSaved = await classRequest.postCourses(allCourses);
    if (isCourseSaved) {
      isCourseBranchFetching(false);
    } else {
      isCourseBranchFailed(true);
      print('ERROR SAVING COURSES');
    }
  }

  void getCourses() async {
    isCourseBranchFetching(true);
    isCourseBranchFailed(false);
    bool isFetchedCourses = await classRequest.fetchAllCourses();
    if (isFetchedCourses) {
      isCourseBranchFetching(false);
      isCourseFetched = true;
    } else {
      isCourseBranchFailed(true);
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
    isCourseBranchFetching(true);
    isCourseBranchFailed(false);
    bool isBranchSaved = await classRequest.postBranches(allBranches);
    print(isBranchSaved);
    if (isBranchSaved) {
      isCourseBranchFetching(false);
    } else {
      isCourseBranchFailed(true);
      print('ERROR SAVING BRANCHES');
    }
  }

  void getBranches() async {
    isCourseBranchFetching(true);
    isCourseBranchFailed(false);
    bool isFetchedBranches = await classRequest.fetchAllBranches();
    print(isFetchedBranches);
    if (isFetchedBranches) {
      isCourseBranchFetching(false);
      isBranchFetched = true;
    } else {
      isCourseBranchFailed(true);
    }
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
}
