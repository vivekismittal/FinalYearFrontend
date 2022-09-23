import 'dart:convert';
import 'package:prezent/app_urls.dart';
import 'package:prezent/models_2.dart/user_model.dart';
import 'package:prezent/requests/request.dart';

class UserRequest {
  AppRequest request = AppRequest();

  Future<bool> postNewUser(User user) async {
 
    bool isPosted = await request.postRequest(AppUrls.createNewUser, user.toJson());

    if (isPosted) {
      print('user posted');
      return true;
    } else {
      return false;
    }
  }
}
