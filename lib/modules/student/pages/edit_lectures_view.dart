import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prezent/controllers/class_controller.dart';
import 'package:prezent/controllers/student_controller.dart';
import 'package:prezent/data/class_data.dart';
import 'package:prezent/data/student_data.dart';

import '../../common_widgets/default_loader.dart';

class EditLectures extends StatelessWidget {
  const EditLectures({super.key});

  @override
  Widget build(BuildContext context) {
    StudentController controller = StudentController();
    List<String> studentSubjectsList = [...registeredStudent!.subjectsCode];
    ClassController classController = Get.put(ClassController());
    classController.getSubjects();
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Edit Lectures'),
              leading: IconButton(
                icon: const Icon(Icons.close_outlined),
                onPressed: () => Get.back(),
              ),
              actions: [
                TextButton(
                    onPressed: () {
                      controller.saveStudentSubjects(studentSubjectsList);
                    },
                    child: const Text('Save'))
              ],
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Text('Added Lectures'),
                      GetBuilder<StudentController>(
                          id: 'Added-Lectures-View',
                          key: const ValueKey('Added-Lectures-View'),
                          builder: (ctrlr) {
                            return Wrap(
                              runSpacing: 10,
                              spacing: 10,
                              children: List.generate(
                                studentSubjectsList.length,
                                (index) => Chip(
                                  label: Text(studentSubjectsList[index]),
                                ),
                              ),
                            );
                          })
                    ],
                  ),
                  Column(
                    children: [
                      const Text('All Lectures'),
                      Obx(
                        () {
                          return classController.isSubjectFetching.isTrue
                              ? DefaultLoader(
                                  isLoad: classController
                                      .isSubjectFetchingFailed.isFalse,
                                  retryFn: () {},
                                )
                              : SizedBox(
                                  height: 500,
                                  child: ListView.builder(
                                      itemCount: allSubjects.length,
                                      itemBuilder: (context, index) {
                                        bool val = studentSubjectsList.contains(
                                            allSubjects[index].subjectCode);
                                        return StatefulBuilder(
                                          builder: ((context, setState) {
                                            return CheckboxListTile(
                                              value: val,
                                              onChanged: (value) {
                                                setState(
                                                  () => val = value!,
                                                );
                                                controller.selectSubject(
                                                  value!,
                                                  allSubjects[index]
                                                      .subjectCode,
                                                  studentSubjectsList,
                                                );
                                              },
                                              selectedTileColor: Get.theme
                                                  .colorScheme.primaryContainer,
                                              title: Row(
                                                children: [
                                                  Text(allSubjects[index]
                                                      .subjectCode),
                                                  Text(
                                                      '  (${allSubjects[index].subjectName})')
                                                ],
                                              ),
                                            );
                                          }),
                                        );
                                      }),
                                );
                        },
                      ),
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
