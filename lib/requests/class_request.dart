import 'dart:convert';
import 'dart:developer';

import 'package:get/get.dart';
import 'package:prezent/app_urls.dart';
import 'package:http/http.dart' as http;
import 'package:prezent/data/class_data.dart';

class ClassRequest {

  RxBool isFetchingCoursesAndBranches = false.obs;
  List<String> fetchedCourses = [];
  List<String> fetchedBranches = [];

  Future<void> fetchAllCoursesAndBranches() async {
    isFetchingCoursesAndBranches(true);
    log('fetching');

    var response = await http.get(Uri.parse(AppUrls.getAllCourseBranch));

    if (response.statusCode == 200) {
      log('fetched');
      var resBody = jsonDecode(response.body);
      print(resBody);

      for (String course in resBody['results']["courses"]) {
        log(course);
        fetchedCourses.add(course);
      }

      for (String branch in resBody['results']["branches"]) {
        log(branch);
        fetchedBranches.add(branch);
      }
      
      allCourses = [...fetchedCourses];
      allBranches = [...fetchedBranches];
      isFetchingCoursesAndBranches(false);
    } else {
      print('Courses not fetched : ${response.statusCode}');
    }
  }
}
