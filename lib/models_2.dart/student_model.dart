class Student {
  final String name;
  final String email;
  final String rollNo;
  final String studentNo;
  final String classId;
  final List<String> subjects;

  Student({
    required this.name,
    required this.email,
    required this.rollNo,
    required this.studentNo,
    required this.classId,
     this.subjects=const[],
  });
  
}
