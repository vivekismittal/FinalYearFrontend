import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prezent/controllers/faculty_controller.dart';
import 'package:prezent/data/faculty_data.dart';
import 'package:prezent/modules/admin/forms/assign_lecture.dart';
import 'package:prezent/modules/common_widgets/view_tile.dart';
import 'package:prezent/modules/common_widgets/default_loader.dart';

class FacultyView extends StatelessWidget {
  const FacultyView({super.key});

  @override
  Widget build(BuildContext context) {
    FacultyController facultyController = Get.put(FacultyController());
    facultyController.getAllFaculties();

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Faculties'),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                ),
                onPressed: Get.back,
              ),
            ),
            GetBuilder<FacultyController>(
              id: 'Faculties-View',
              key: const ValueKey('Faculties-View'),
              builder: (controller) {
                return SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      facultyController.isAllFacultiesFetching
                          ? DefaultLoader(
                              isLoad: !facultyController
                                  .isAllFacultiesFetchingFailed,
                              retryFn: facultyController.getAllFaculties,
                            )
                          : Column(
                              children: List.generate(
                                allFaculties.length,
                                (index) => FacultyTile(
                                  name: allFaculties[index].name,
                                  email: allFaculties[index].email,
                                  controller: facultyController,
                                ),
                              ),
                            ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

class FacultyTile extends StatefulWidget {
  const FacultyTile({
    Key? key,
    required this.name,
    required this.email,
    required this.controller,
  }) : super(key: key);
  final String name;
  final String email;
  final FacultyController controller;
  @override
  State<FacultyTile> createState() => _FacultyTileState();
}

class _FacultyTileState extends State<FacultyTile> {
  bool isExpanded = false;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ViewTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.name,
                style: Get.textTheme.titleMedium,
              ),
              Text(
                widget.email,
                style: Get.textTheme.labelMedium,
              ),
            ],
          ),
          action: IconButton(
            icon: const Icon(Icons.keyboard_arrow_down_outlined),
            onPressed: () {
              widget.controller.getAllLecturesByFaculty(widget.email);
              setState(() {
                isExpanded = !isExpanded;
                log('clicked');
              });
            },
          ),
        ),
        Visibility(
          visible: isExpanded,
          child: Padding(
            padding: const EdgeInsets.only(
              left: 16,
              right: 16,
            ),
            child: GetBuilder<FacultyController>(
              id: 'Faculty-Lecture-View-${widget.email}',
              key: ValueKey('Faculty-Lecture-View-${widget.email}'),
              builder: (controller) {
                return controller.isFacultyLecturesFetching[widget.email]!
                    ? DefaultLoader(
                        isLoad: controller
                            .isFacultyLecturesFetchingFailed[widget.email]!,
                        retryFn: () =>
                            controller.getAllLecturesByFaculty(widget.email),
                      )
                    : Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          facultyWiseLectures[widget.email]!.isEmpty
                              ? const Text('Zero Lecture Assigned Yet')
                              : Column(
                                  children: List.generate(
                                    facultyWiseLectures[widget.email]!.length,
                                    (index) => Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        RichText(
                                          text: TextSpan(
                                            text: facultyWiseLectures[
                                                    widget.email]![index]
                                                .classId,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyMedium,
                                            children: [
                                              TextSpan(
                                                text:
                                                    '  (${facultyWiseLectures[widget.email]![index].subjectCode})',
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                              ),
                                            ],
                                          ),
                                        ),
                                        const Padding(
                                          padding: EdgeInsets.only(bottom: 8.0),
                                          child: Divider(),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                          ActionChip(
                            backgroundColor:
                                Get.theme.primaryColor.withOpacity(.3),
                            label: Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                Text(
                                  'Assign Lecture',
                                  style: Get.textTheme.labelSmall,
                                ),
                                Icon(
                                  Icons.add,
                                  color: Get.theme.colorScheme.secondary,
                                  size: 16,
                                ),
                              ],
                            ),
                            onPressed: () {
                              assigningLectureForm(
                                controller,
                                widget.email,
                              );
                            },
                          ),
                        ],
                      );
              },
            ),
          ),
        )
      ],
    );
  }
}
