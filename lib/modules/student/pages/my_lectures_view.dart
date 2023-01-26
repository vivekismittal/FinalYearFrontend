import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prezent/data/student_data.dart';
import 'package:prezent/modules/common_widgets/default_loader.dart';
import 'package:prezent/modules/common_widgets/view_tile.dart';
import 'package:prezent/modules/student/pages/edit_lectures_view.dart';

import '../../../controllers/student_controller.dart';

class MyLectures extends StatelessWidget {
  const MyLectures({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('My Lectures'),
              actions: [
                TextButton(
                  onPressed: () => Get.to(() => const EditLectures()),
                  child: const Text('Edit'),
                ),
              ],
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                ),
                onPressed: Get.back,
              ),
            ),
            GetBuilder<StudentController>(
              id: 'Student-Lecture-View',
              key: const ValueKey('Student-Lecture-View'),
              builder: (controller) {
                return SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      controller.isStudentFetching
                          ? DefaultLoader(
                              isLoad: !controller.isStudentFetchingFailed,
                              retryFn: controller.getStudent,
                            )
                          : Column(
                              children: List.generate(
                                registeredStudent!.subjectsCode.length,
                                (index) => ViewTile(
                                  title: Text(
                                    registeredStudent!.subjectsCode[index],
                                  ),
                                ),
                              ),
                            ),
                    ],
                  ),
                );
              },
            )
          ],
        ),
      ),
    );
  }
}
