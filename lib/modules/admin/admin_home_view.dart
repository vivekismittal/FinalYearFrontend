import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:prezent/modules/forms/create_class.dart';
import 'package:prezent/modules/forms/create_new_user.dart';

import '../student/pages/home_view/home_view.dart';

class AdminHomeView extends StatelessWidget {
  const AdminHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            userChip(
              'Create Class',
              () => Get.to(const CreateClass()),
            ),
            const SizedBox(
              height: 16,
            ),
            userChip(
              'Create new User',
              () => Get.to(() => const CreateNewUserForm()),
            ),
            
          ],
        ),
      ),
    );
  }


  ActionChip userChip(String user, void Function() onTap) {
    return ActionChip(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      label: Text(
        'I am $user',
        style: Get.textTheme.displayMedium,
      ),
      onPressed: onTap,
    );
  }
}
