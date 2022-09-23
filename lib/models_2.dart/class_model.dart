
import 'dart:convert';

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
        students = (json['students'] as List).map((e) => jsonDecode(e) as int).toList();


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
