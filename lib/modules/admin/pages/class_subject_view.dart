import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prezent/data/class_data.dart';
import 'package:prezent/modules/admin/forms/create_class_subject_form.dart';
import 'package:prezent/modules/common_widgets/view_tile.dart';
import 'package:prezent/modules/common_widgets/default_loader.dart';

import '../../../controllers/class_controller.dart';

class ClassOrSubjectView extends StatelessWidget {
  const ClassOrSubjectView({
    super.key,
    this.isSubjectView = false,
  });

  final bool isSubjectView;
  @override
  Widget build(BuildContext context) {
    ClassController controller = Get.put(ClassController());

    ColorScheme colorScheme = Get.theme.colorScheme;
    isSubjectView ? controller.getSubjects() : controller.getClasses();

    return SafeArea(
      child: Scaffold(
        body: GetBuilder<ClassController>(
          id: 'All-Class-Subject-View',
          key: const ValueKey('All-Class-Subject-View'),
          builder: (controller) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  pinned: true,
                  title: Text(!isSubjectView ? 'All Classes' : "All Subjects"),
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                    ),
                    onPressed: Get.back,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {
                        isSubjectView
                            ? showCreateClassOrSubjectDialog(
                                controller,
                                true,
                              )
                            : showCreateClassOrSubjectDialog(
                                controller,
                                false,
                              );
                      },
                      child: Text(
                        'Create ${isSubjectView ? 'Subject' : 'Class'}',
                      ),
                    ),
                  ],
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Obx(
                        () {
                          List<String> classIdList = [];
                          if (!isSubjectView) {
                            classIdList = controller.getClassIds;
                          }
                          return (isSubjectView
                                      ? controller.isSubjectFetching
                                      : controller.isClassFetching)
                                  .isFalse
                              ? Column(
                                  children: List.generate(
                                    isSubjectView
                                        ? allSubjects.length
                                        : allClasses.length,
                                    (index) => ViewTile(
                                      title: isSubjectView
                                          ? RichText(
                                              text: TextSpan(
                                                text: allSubjects[index]
                                                    .subjectName,
                                                style:
                                                    Get.textTheme.titleMedium,
                                                children: [
                                                  TextSpan(
                                                    text:
                                                        '   (${allSubjects[index].subjectCode})',
                                                    style: Get
                                                        .textTheme.labelMedium,
                                                  ),
                                                ],
                                              ),
                                            )
                                          : Text(classIdList[index]),
                                    ),
                                  ),
                                )
                              : DefaultLoader(
                                  isLoad: (isSubjectView
                                          ? controller.isSubjectFetchingFailed
                                          : controller.isClassFailed)
                                      .isFalse,
                                  retryFn: isSubjectView
                                      ? controller.getSubjects
                                      : controller.getClasses,
                                );
                        },
                      ),
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
