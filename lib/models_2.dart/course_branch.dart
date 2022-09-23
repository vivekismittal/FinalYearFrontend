class Course {
  final String course;

  Course({required this.course});

  Map<String, dynamic> toJson() => {
        'course': course,
      };
}

List<Course> listOfCoursefromJson(List<dynamic> jsonList) {
  List<Course> coursesList = [];
  for (var json in jsonList) {
    coursesList.add(
      Course(
        course: json["course"],
      ),
    );
  }
  return coursesList;
}

class Branch {
  final String branch;

  Branch({required this.branch});

  Map<String, dynamic> toJson() => {
        'branch': branch,
      };
}

List<Branch> listOfBranchFromJson(List<dynamic> jsonList) {
  List<Branch> branchesList = [];
  for (var json in jsonList) {
    branchesList.add(
      Branch(
        branch: json["branch"],
      ),
    );
  }
  return branchesList;
}
