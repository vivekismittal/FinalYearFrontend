import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:prezent/data/user_data.dart';
import 'package:prezent/modules/admin/pages/admin_home_view.dart';
import 'package:prezent/modules/faculty/pages/home/home_view.dart';
import 'package:prezent/modules/student/pages/student_home_view.dart';
import 'package:prezent/requests/user_request.dart';

import '../models_2.dart/user_model.dart';

class UserController extends GetxController {
  UserRequest userRequest = UserRequest();
  TextEditingController emailInput = TextEditingController();
  bool isUserSigned = false;
  bool isUserSigning = false;
  bool isUserSigningFailed = false;
  void updateUserView() {}
  void getUserById() async {
    isUserSigning = true;
    bool userSigned = await userRequest.getUserById(emailInput.text);
    if (userSigned) {
      isUserSigned = true;
      isUserSigning = false;
      switch (activeUser.role) {
        case "STUDENT":
          {
            Get.to(() => const StudentHomeView());
          }
          break;
        case "FACULTY":
          {
            Get.to(() => const FacultyHomeView());
          }
          break;
        case "ADMIN":
          {
            Get.to(() => const AdminHomeView());
          }
          break;
      }
    } else {
      isUserSigningFailed = true;
    }
    updateUserView();
  }

  final TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController role = TextEditingController();
  RxBool isUserCreationPending = false.obs;

  void createNewUser(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      isUserCreationPending(true);
      User newUser = User(
        name: name.text,
        email: email.text,
        mobile: int.parse(mobile.text),
        role: role.text,
      );
      bool isPosted = await UserRequest().postNewUser(newUser);
      Future.delayed(const Duration(seconds: 5), () {
        isUserCreationPending(false);
        if (isPosted) {
          formKey.currentState!.reset();
        } else {
          print('Validation ERROR');
        }
      });
    }
  }
}
