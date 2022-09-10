import './models.dart';

class FacultyModel {
  final String name;
  final String emailId;
  final String mobileNo;
  final List<ClassRoomModel> classRooms;

  FacultyModel({
    required this.name,
    required this.emailId,
    required this.mobileNo,
    required this.classRooms,
  });
}
