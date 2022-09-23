import 'dart:developer';
import 'package:get/get.dart';
import 'package:prezent/app_urls.dart';
import 'package:prezent/constants.dart';
import 'package:prezent/data/class_data.dart';
import 'package:prezent/models_2.dart/class_model.dart';
import 'package:prezent/models_2.dart/course_branch.dart';
import 'package:prezent/requests/request.dart';

class ClassRequest {
  AppRequest request = AppRequest();

  //BRANCHES//////////////
  Future<bool> postBranches(List<Branch> body) async {
    var reqBody = {
      'email': adminEmail,
      'count': body.length,
      'branches': List.generate(
        body.length,
        (index) => body[index].toJson(),
      ),
    };
    var result = await request.postRequest(ClassUrls.postBranches, reqBody);
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
      var result = await request.getRequest(ClassUrls.getAllBranches);
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
      'email': adminEmail,
      'count': body.length,
      'courses': List.generate(
        body.length,
        (index) => body[index].toJson(),
      ),
    };
    var result = await request.postRequest(ClassUrls.postCourses, reqBody);
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

      var result = await request.getRequest(ClassUrls.getAllCourses);
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
    log('fetching Classes');
    var result = await request.getRequest(ClassUrls.getAllClasses);
    try {
      if (result != null) {
        print('fetched Courses');
        allClasses = [...listOfClassfromJson(result["results"]["classes"])];
        return true;
      }
      print('ERROR FETCHING CLASSES');
      return false;
    } catch (e) {
      print(e);
      return false;
    }
  }
}
