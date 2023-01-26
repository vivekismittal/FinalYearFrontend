class Student {
  final String email;
  final int rollNo;
  final int studentNo;
  final String classId;
   List<String> subjectsCode;

  Student({
    required this.email,
    required this.rollNo,
    required this.studentNo,
    required this.classId,
    this.subjectsCode = const [],
  });

  Student.fromJson(Map<String, dynamic> json)
      : email = json['email'] as String,
        rollNo = json['rollNo'] as int,
        studentNo = json['studentNo'] as int,
        classId = json['classId'] as String,
        subjectsCode = (json['subjectsCode'] != null)
            ? (json['subjectsCode'] as List).map((e) => e as String).toList()
            : [];

  Map<String, dynamic> toJson() => {
       
        'email': email,
        'rollNo': rollNo,
        'studentNo': studentNo,
        'classId': classId,
      };
}
