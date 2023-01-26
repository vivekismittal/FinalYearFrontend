import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prezent/modules/admin/pages/class_subject_view.dart';
import 'package:prezent/modules/admin/pages/course_branch_view.dart';
import 'package:prezent/modules/admin/pages/faculties_view.dart';

class AdminHomeView extends StatelessWidget {
  const AdminHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            actionChip(
              'All Branches',
              () => Get.to(() => const CourseOrBranchView(
                    isBranch: true,
                  )),
            ),
            const SizedBox(
              height: 16,
            ),
            actionChip(
              'All Courses',
              () => Get.to(() => const CourseOrBranchView(
                    isBranch: false,
                  )),
            ),
            const SizedBox(
              height: 16,
            ),
            actionChip(
              'All Classes',
              () => Get.to(() => const ClassOrSubjectView()),
            ),
            const SizedBox(
              height: 16,
            ),
            actionChip(
              'All Subjects',
              () => Get.to(() => const ClassOrSubjectView(isSubjectView: true)),
            ),
            const SizedBox(
              height: 16,
            ),
            actionChip(
              'Faculties',
              () => Get.to(() => const FacultyView()),
            ),
          ],
        ),
      ),
    );
  }

  ActionChip actionChip(String user, void Function() onTap) {
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
