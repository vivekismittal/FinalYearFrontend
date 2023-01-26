class Lecture {
  final String email;
  final String classId;
  final String subjectCode;
  final bool isOpen;
  // final List attendanceRecords;
  Lecture({
    required this.email,
    required this.classId,
    required this.subjectCode,
     this.isOpen=false ,
    // required this.attendanceRecords,
  });

  Lecture.fromJson(Map<String, dynamic> json)
      : email = json['email'],
        classId = json['classId'],
        subjectCode = json['subjectCode'],
        isOpen = json['isOpen'];
  // attendanceRecords = json['attendanceRecords'];

  Map<String, dynamic> toJson() => {
        'email': email,
        'classId': classId,
        'subjectCode': subjectCode,
      };
}

List<Lecture> listOflecturefromJson(List<dynamic> jsonList) {
  List<Lecture> lectureList = [];
  for (var json in jsonList) {
    print(json);
    lectureList.add(
      Lecture.fromJson(json),
    );
  }
  return lectureList;
}
