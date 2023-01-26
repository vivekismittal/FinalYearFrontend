import 'dart:developer';

import 'package:prezent/utils/app_urls.dart';
import 'package:prezent/data/user_data.dart';
import 'package:prezent/models_2.dart/user_model.dart';
import 'package:prezent/requests/request.dart';

class UserRequest {
  AppRequest request = AppRequest();

  Future<bool> postNewUser(User user) async {
    var result =
        await request.postRequest(UserUrls.createNewUser, user.toJson(),'');

    if (result != null) {
      print('user posted');
      return true;
    } else {
      return false;
    }
  }

  Future<bool> getUserById(String email) async {
    try {
      var result = await request.getRequest(UserUrls.getUser,{'email':email});
      if (result != null) {
        activeUser = User.fromJson(result['results']['user']);
        return true;
      } else {
        return false;
      }
    } catch (e) {
      log('$e');
      return false;
    }
  }
}
