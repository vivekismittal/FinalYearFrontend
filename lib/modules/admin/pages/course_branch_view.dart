import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:prezent/controllers/class_controller.dart';
import 'package:prezent/data/class_data.dart';

import '../../common_widgets/form_input_field.dart';
import '../widgets/view_tile.dart';

class CourseBranchView extends StatelessWidget {
  CourseBranchView({super.key, required this.isBranch});

  final bool isBranch;
  ColorScheme colorScheme = Get.theme.colorScheme;
  ClassController controller = Get.put(ClassController());
  bool onEdit = false;

  @override
  Widget build(BuildContext context) {
    if ((isBranch ? isBranchFetched : isCourseFetched) == false) {
      controller.lastFn =
          isBranch ? controller.getBranches : controller.getCourses;
      isBranch ? controller.getBranches() : controller.getCourses();
    }
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<ClassController>(
          id: 'Course-Branch-View',
          key: const ValueKey('Course-Branch-View'),
          builder: (controller) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: Text(
                    isBranch ? 'Branches' : 'Courses',
                  ),
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                    ),
                    onPressed: Get.back,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        if (onEdit) {
                          controller.lastFn = isBranch
                              ? controller.updateBranch
                              : controller.updateCourse;
                          isBranch
                              ? controller.updateBranch()
                              : controller.updateCourse();
                        }
                        onEdit = !onEdit;
                        controller.updateCourseBranchView();
                      },
                      child: Text(
                        onEdit ? 'Save' : 'Edit',
                      ),
                    ),
                  ],
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Obx(
                        () => Column(
                          children: controller.isCourseBranchFetching.isFalse
                              ? List.generate(
                                  isBranch
                                      ? allBranches.length
                                      : allCourses.length,
                                  (index) => ViewTile(
                                    text: isBranch
                                        ? allBranches[index].branch
                                        : allCourses[index].course,
                                    onEdit: onEdit,
                                    onRemove: () => isBranch
                                        ? controller.removeBranch(index)
                                        : controller.removeCourse(index),
                                  ),
                                )
                              : [
                                  LottieBuilder.asset(
                                    'lottieFiles/pixel-loader.json',
                                    height: 300,
                                    frameRate: FrameRate.max,
                                    animate:
                                        controller.isCourseBranchFailed.isFalse,
                                  ),
                                  Visibility(
                                    visible:
                                        controller.isCourseBranchFailed.isTrue,
                                    child: IconButton(
                                      onPressed: controller.lastFn,
                                      icon: Icon(
                                        Icons.replay_circle_filled_outlined,
                                        color: colorScheme.error,
                                        semanticLabel: 'Retry',
                                        size: 30,
                                      ),
                                    ),
                                  )
                                ],
                        ),
                      ),
                      Visibility(
                        visible: onEdit,
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Form(
                            key: controller.courseBranchFormKey,
                            autovalidateMode:
                                AutovalidateMode.onUserInteraction,
                            child: Column(
                              children: [
                                FormInputField(
                                  controller: isBranch
                                      ? controller.newBranch
                                      : controller.newCourse,
                                  label: isBranch ? 'Add Branch' : 'Add Course',
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                TextButton(
                                  onPressed: isBranch
                                      ? controller.addNewBranch
                                      : controller.addNewCourse,
                                  child: const Text('Add'),
                                ),
                              ],
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ],
            );
          },
        ),
      ),
    );
  }
}
