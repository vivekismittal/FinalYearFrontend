import 'package:faker/faker.dart';
import 'models.dart';

List<Course> dummyCourses = [
  Course.btech,
  Course.mtech,
];
List<Branch> dummyBranches = [
  Branch.ce,
  Branch.cse,
  Branch.ece,
  Branch.ei,
  Branch.en,
  Branch.me,
];

List<String> dummyClassId = [
  'CSE-1',
  'CSE-2',
  'CSE-3',
  'ECE-1',
  'ECE-2',
  'ECE-3'
];

List<String> dummySubjects = [
  'Artificial Intelligence',
  'Cloud Computing',
  'DataBase Management System',
  'Physics',
  'Mechanics',
  'IOT',
];

List<StudentModel> get dummyStudents => List.generate(
  faker.randomGenerator.integer(100, min: 45),
  (index) => StudentModel(
    name: faker.company.person.name(),
    emailId: '${faker.company.person.firstName()}@gmail.com',
    rollNo: index + 1,
    subjects: List.generate(
      dummySubjects.length,
      (index) => Subject(
        subjectCode: dummySubjects[index],
        attendances: List.generate(
          100,
          (index) => DateAttendance(
            dateTime: faker.date.dateTime(maxYear: 2022, minYear: 2021),
            attendanceCount: faker.randomGenerator.integer(5),
          ),
        ),
      ),
    ),
  ),
);

List<ClassModel> dummyClasses = List.generate(
  dummyClassId.length,
  (index) => ClassModel(
    course: (dummyCourses..shuffle()).first,
    branch: (dummyBranches..shuffle()).first,
    section: faker.randomGenerator.integer(4, min: 1),
    passingYear: faker.randomGenerator.integer(2030, min: 2022),
    classId: dummyClassId[index],
    students: dummyStudents,
  ),
);

List<ClassRoomModel> dummyListOfClassRoom = List.generate(
  40,
  (index) {
    String classId = (dummyClassId..shuffle()).first;
    int noOfStudent =
        dummyClasses.where((el) => el.classId == classId).first.students.length;
    return ClassRoomModel(
      classSubjectId: ClassSubjectIdModel(
        classId: classId,
        subjectCode: (dummySubjects..shuffle()).first,
        noOfStudent: noOfStudent,
      ),
      timeWiseAttendanceList: List.generate(
        1000,
        (index) => TimeWiseAttendanceModel(
          startedat: faker.date.dateTime(
            minYear: 2021,
            maxYear: 2023,
          ),
          durationInMin: faker.randomGenerator.integer(120, min: 40),
          studentAttendanceList: List.generate(
            noOfStudent,
            (index) => StudentAttendanceModel(
              rollNo: index + 1,
              isPresent: faker.randomGenerator.boolean(),
            ),
          ),
        ),
      ),
    );
  },
);

FacultyModel dummyFaculty = FacultyModel(
  name: 'BN Pandey',
  emailId: 'pandey@akgec.ac.in',
  mobileNo: '765726385',
  classRooms: dummyListOfClassRoom,
);
