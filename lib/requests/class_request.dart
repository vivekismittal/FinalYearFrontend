import 'dart:developer';
import 'package:prezent/data/user_data.dart';
import 'package:prezent/utils/app_urls.dart';
import 'package:prezent/data/class_data.dart';
import 'package:prezent/models_2.dart/class_subject.dart';
import 'package:prezent/models_2.dart/course_branch.dart';
import 'package:prezent/requests/request.dart';

class ClassRequest {
  AppRequest request = AppRequest();

  //BRANCHES//////////////
  Future<bool> postBranches(List<Branch> body) async {
    var reqBody = {
      'count': body.length,
      'branches': List.generate(
        body.length,
        (index) => body[index].toJson(),
      ),
    };
    var result = await request.postRequest(ClassUrls.postBranches, reqBody,activeUser.email);
    if (result != null) {
      print('Branch posted');
      allBranches = [...listOfBranchFromJson(result['results']["branches"])];
      return true;
    }
    return false;
  }

  Future<bool> fetchAllBranches() async {
    try {
      log('fetching Branches');
      var result = await request.getRequest(ClassUrls.getAllBranches,{'email':activeUser.email});
      if (result != null) {
        log('fetched');
        // print(result);
        allBranches = [...listOfBranchFromJson(result['results']["branches"])];
        return true;
      }
      print('Error fetching Branches');
      return false;
    } catch (e) {
      log('$e');
      return false;
    }
  }

  ////////////////////////
  ///
  //COURSES//////////////
  Future<bool> postCourses(List<Course> body) async {
    var reqBody = {
      'count': body.length,
      'courses': List.generate(
        body.length,
        (index) => body[index].toJson(),
      ),
    };
    var result = await request.postRequest(ClassUrls.postCourses, reqBody,activeUser.email);
    if (result != null) {
      print('Course posted');
      allCourses = [...listOfCoursefromJson(result['results']["courses"])];
      return true;
    }
    print('Error fetching Courses');
    return false;
  }

  Future<bool> fetchAllCourses() async {
    try {
      log('fetching Courses');

      var result = await request.getRequest(ClassUrls.getAllCourses,{'email':activeUser.email});
      if (result != null) {
        log('fetched Courses');
        // print(result);
        allCourses = [...listOfCoursefromJson(result['results']["courses"])];
        return true;
      }
      print('Error fetching Courses');
      return false;
    } catch (e) {
      log('$e');
      return false;
    }
  }

  ////////////////////////
  ///
  ///CLASSES//////////////
  Future<bool> fetchAllClasses() async {
    try {
      log('fetching Classes');
      var result = await request.getRequest(ClassUrls.getAllClasses,{'email':activeUser.email});
      if (result != null) {
        print('fetched Classes');
        allClasses = [...listOfClassfromJson(result["results"]["classes"])];

        return true;
      }
      print('ERROR FETCHING CLASSES');
      return false;
    } catch (e) {
      throw Exception(e);
      print(e);
      return false;
    }
  }

  Future<bool> postClass(Class classBody) async {
    try {
      var reqBody = { 'newClass': classBody.toJson()};
      var result = await request.postRequest(ClassUrls.postClass, reqBody,activeUser.email);
      if (result != null) {
        allClasses.add(Class.fromJson(result["results"]["newClass"]));
        print('Class posted');
        return true;
      }
      print('Error Saving Classes');
      return false;
    } catch (e) {
      throw Exception(e);
      log('$e');
      return false;
    }
  }

  /////SUBJECT/////
  Future<bool> fetchAllSubjects() async {
    try {
      log('fetching Subjects');
      var result = await request.getRequest(ClassUrls.getAllSubjects,{'email':activeUser.email});
      if (result != null) {
        print('fetched Subjects');
        allSubjects = [...listOfSubjectfromJson(result["results"]["subjects"])];

        return true;
      }
      print('ERROR FETCHING SUBJECTS');
      return false;
    } catch (e) {
      throw Exception(e);
      print(e);
      return false;
    }
  }

  Future<bool> postSubject(Subject subjectBody) async {
    try {
      var reqBody = { 'newSubject': subjectBody.toJson()};
      var result = await request.postRequest(ClassUrls.postSubject, reqBody,activeUser.email);
      if (result != null) {
        allSubjects.add(Subject.fromJson(result["results"]["newSubject"]));
        print('Subject posted');
        return true;
      }
      print('Error Saving Subjects');
      return false;
    } catch (e) {
      throw Exception(e);
      log('$e');
      return false;
    }
  }
}
