import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prezent/modules/admin/pages/classes_view.dart';
import 'package:prezent/modules/admin/pages/course_branch_view.dart';
import 'package:prezent/modules/forms/create_class.dart';
import 'package:prezent/modules/forms/create_new_user.dart';

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
              'All Branches',
              () => Get.to(() =>  CourseBranchView(isBranch: true,)),
            ),
            const SizedBox(
              height: 16,
            ),
            userChip(
              'All Courses',
              () => Get.to(() =>  CourseBranchView(isBranch: false,)),
            ), const SizedBox(
              height: 16,
            ),
            userChip(
              'All Classes',
              () => Get.to(() =>  ClassesView()),
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
        user,
        style: Get.textTheme.titleLarge,
      ),
      onPressed: onTap,
    );
  }
}
