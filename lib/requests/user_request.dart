import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;
import 'package:prezent/app_urls.dart';
import 'package:prezent/models/user_model.dart';

class UserRequest {
  // RxBool isPostingUsers = false.obs;

  Future<bool> postNewUser(User user) async {
    // print(user);
    // isPostingUsers(true);
    var jsonUser = json.encode(user.toJson());
    print(jsonUser);
    var response = await http.post(
      Uri.parse(AppUrls.createNewUser),
      headers: <String, String>{
        'Content-Type': 'application/json; charset=UTF-8',
      },
      body: jsonUser,
    );

    print('wd');
    if (response.statusCode == 201) {
      // isPostingUsers(false);
      print('user posted');
      return true;
    } else {
      print('Error posting User ${response.statusCode}');
      return false;
    }
  }
}
