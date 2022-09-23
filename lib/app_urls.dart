const String baseUrl = "http://127.0.0.1:8000/api";

class AppUrls {
  static const String createNewUser = "$baseUrl/user/new";
  static const String getAllCourseBranch =
      '$baseUrl/class/getAllCoursesBranches';
}

class ClassUrls {
  //BRANCH
  static const postBranches = '$baseUrl/branches/new';
  static const getAllBranches = '$baseUrl/branches';

  //COURSE
  static const postCourses = '$baseUrl/courses/new';
  static const getAllCourses = '$baseUrl/courses';

  //CLASS
  static const postClass = '$baseUrl/classes/new';
  static const getAllClasses = '$baseUrl/classes';
}
