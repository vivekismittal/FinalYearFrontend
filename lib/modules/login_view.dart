import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prezent/controllers/user_controller.dart';
import 'package:prezent/modules/common_widgets/form_input_field.dart';

import 'forms/create_new_user.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  @override
  Widget build(BuildContext context) {
    UserController userController = Get.put(UserController(), permanent: true);
    return Scaffold(
      body: Center(
        child: SizedBox(
          width: 400,
          child: Form(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FormInputField(
                  label: 'Email ID',
                  controller: userController.emailInput,
                ),
                Row(
                  children: [
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () {
                          userController.getUserById();
                        },
                        child: const Text('Login'),
                      ),
                    ),
                  ],
                ),
                TextButton(
                  onPressed: () => Get.to(() => const CreateNewUserForm()),
                  child: const Text('New?'),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
