import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prezent/controllers/class_controller.dart';
import 'package:prezent/data/class_data.dart';
import 'package:prezent/modules/common_widgets/default_loader.dart';

import '../../common_widgets/form_input_field.dart';
import '../../common_widgets/view_tile.dart';

class CourseOrBranchView extends StatelessWidget {
  const CourseOrBranchView({super.key, required this.isBranch});

  final bool isBranch;
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Get.theme.colorScheme;
    ClassController controller = Get.put(ClassController());
    bool onEdit = false;

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
                        () => (isBranch
                                ? controller.isBranchFetching.isFalse
                                : controller.isCourseFetching.isFalse)
                            ? Column(
                                children: List.generate(
                                isBranch
                                    ? allBranches.length
                                    : allCourses.length,
                                (index) => ViewTile(
                                  title: isBranch
                                      ? Text(allBranches[index].branch)
                                      : Text(allCourses[index].course),
                                  action: Visibility(
                                    visible: onEdit,
                                    child: IconButton(
                                      padding: const EdgeInsets.all(0),
                                      icon: Icon(
                                        Icons.delete_outline_rounded,
                                        color: colorScheme.error,
                                      ),
                                      onPressed: () => isBranch
                                          ? controller.removeBranch(index)
                                          : controller.removeCourse(index),
                                    ),
                                  ),
                                ),
                              ))
                            : DefaultLoader(
                                isLoad: (isBranch
                                        ? controller.isBranchFailed
                                        : controller.isCourseFailed)
                                    .isFalse,
                                retryFn: controller.lastFn,
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
                                  autoFocus: true,
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
