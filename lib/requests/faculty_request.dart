import 'dart:developer';
import 'package:prezent/utils/app_urls.dart';
import 'package:prezent/data/faculty_data.dart';
import 'package:prezent/models_2.dart/lecture_model.dart';
import 'package:prezent/models_2.dart/user_model.dart';
import 'package:prezent/requests/request.dart';

import '../data/user_data.dart';

class FacultyRequest {
  AppRequest request = AppRequest();

  Future<bool> fetchAllFaculties() async {
    try {
      log('Faculties fetching');
      var result = await request.getRequest(FacultyUrls.getAllFaculties,{'email':activeUser.email});
      if (result != null) {
        log('Faculty Fetched');
        allFaculties = [
          ...listOfUserfromJson(
            result["result"]["allFaculties"],
          )
        ];
        return true;
      }
      return false;
    } catch (e) {
      log('$e');
      return false;
    }
  }

  Future<bool> fetchAllLecturesByFaculty(String email) async {
    try {
      log('fetching lectures');
      var result = await request.getRequest(
        FacultyUrls().getAllLecturesByFaculty(email),{'email':activeUser.email}
      );

      if (result != null) {
        log('lectures fetched');
        facultyWiseLectures[email] =
            listOflecturefromJson(result['result']['allLectures']);
        return true;
      }
      log('ERROR fetching lectures');
      return false;
    } catch (e) {
      log('$e');
      return false;
    }
  }

  Future<bool> assignFacultyLecture(Lecture newLecture) async {
    try {
      log('Lecture Assigning...');

      var result = await request.postRequest(
          FacultyUrls.assignFacutltyLecture, newLecture.toJson(),activeUser.email);

      if (result != null) {
        facultyWiseLectures[newLecture.email]!.add(
          Lecture.fromJson(
            result['result']['newLecture'],
          ),
        );
        log('Lecture Assigned');
        
        return true;
      } else {
        log('Error assigning Lectures');
        return false;
      }
    } catch (e) {
      log('$e');
      return false;
    }
  }
}
