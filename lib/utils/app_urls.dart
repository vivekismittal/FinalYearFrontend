const String baseUrl = "127.0.0.1:8000";

class ClassUrls {
  //BRANCH
  static Uri postBranches = Uri.http(baseUrl, '/api/branches/new');
  static Uri getAllBranches = Uri.http(baseUrl, '/api/branches');

  //COURSE
  static Uri postCourses = Uri.http(baseUrl, '/api/courses/new');
  static Uri getAllCourses = Uri.http(baseUrl, '/api/courses');

  //CLASS
  static Uri postClass = Uri.http(baseUrl, '/api/classes/new');
  static Uri getAllClasses = Uri.http(baseUrl, '/api/classes');

  //SUBJECT
  static Uri postSubject = Uri.http(baseUrl, '/api/subjects/new');

  static Uri getAllSubjects = Uri.http(baseUrl, '/api/subjects');
}

class StudentUrls {
  static Uri registerStudent = Uri.http(baseUrl, '/api/students/new');
  static Uri getStudent = Uri.http(baseUrl, '/api/students/get');
  static Uri getStudentSubjects = Uri.http(baseUrl, '/api/students/get-subjects');
  static Uri saveStudentSubjects = Uri.http(baseUrl, '/api/students/assign-subjects');
}

class FacultyUrls {
  static Uri getAllFaculties = Uri.http(baseUrl, '/api/faculty/all');

  Uri getAllLecturesByFaculty(String email) =>
      Uri.http(baseUrl, '/api/faculty/lectures/all', {'id': email});

  static Uri assignFacutltyLecture =
      Uri.http(baseUrl, '/api/faculty/lectures/new');
}

class UserUrls{
  static Uri createNewUser = Uri.http(baseUrl, '/api/user/new');
  static Uri getUser = Uri.http(baseUrl, '/api/user/get');

}