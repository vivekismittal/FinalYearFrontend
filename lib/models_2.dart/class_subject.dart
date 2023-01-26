////CLASS/////
class Class {
  final String course;
  final String branch;
  final int section;
  final int passingYear;
  final String classId;
  final List<int> students;

  Class({
    required this.course,
    required this.branch,
    required this.section,
    required this.passingYear,
    required this.classId,
    this.students = const [],
  });

  Class.fromJson(Map<String, dynamic> json)
      : course = json['course'] as String,
        branch = json['branch'] as String,
        section = json['section'] as int,
        passingYear = json['passingYear'] as int,
        classId = json['classId'] as String,
        students = (json['students'] as List).map((e) => e as int).toList();

  Map<String, dynamic> toJson() => {
        'course': course,
        'branch': branch,
        'section': section,
        'passingYear': passingYear,
        'classId': classId,
      };
}

List<Class> listOfClassfromJson(List<dynamic> jsonList) {
  List<Class> classesList = [];
  for (var json in jsonList) {
    classesList.add(
      Class.fromJson(json),
    );
  }
  return classesList;
}
//////////////////

////SUBJECT///////
class Subject {
  final String subjectName;
  final String subjectCode;

  Subject({
    required this.subjectName,
    required this.subjectCode,
  });

  Subject.fromJson(Map<String, dynamic> json)
      : subjectName = json['subjectName'],
        subjectCode = json['subjectCode'];

  Map<String, dynamic> toJson() => {
        'subjectName': subjectName,
        'subjectCode': subjectCode,
      };
}

List<Subject> listOfSubjectfromJson(List<dynamic> jsonList) {
  List<Subject> subjectsList = [];
  for (var json in jsonList) {
    subjectsList.add(
      Subject.fromJson(json),
    );
  }
  return subjectsList;
}
