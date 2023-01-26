class User {
  final String name;
  final String email;
  final int mobile;
  final String role;
   bool isRegistered;
  User({
    required this.name,
    required this.email,
    required this.mobile,
    required this.role,
    this.isRegistered=false, 
  });
  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        mobile = json['mobile'] as int,
        role = json['role'],
        isRegistered=json["isRegistered"];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'mobile': mobile,
        'role': role,
      };
}

List<User> listOfUserfromJson(List<dynamic> jsonList) {
  List<User> userList = [];
  for (var json in jsonList) {
    userList.add(
      User.fromJson(json),
    );
  }
  return userList;
}
