import 'dart:convert';

class User {
  final String name;
  final String email;
  final int mobile;
  final String role;

  User({
    required this.name,
    required this.email,
    required this.mobile,
    required this.role,
  });
  User.fromJson(Map<String, dynamic> json)
      : name = json['name'],
        email = json['email'],
        mobile = json['mobile'] as int,
        role = json['role'];

  Map<String, dynamic> toJson() => {
        'name': name,
        'email': email,
        'mobile': mobile,
        'role': role,
      };
}

// enum Role { student, admin, faculty }


