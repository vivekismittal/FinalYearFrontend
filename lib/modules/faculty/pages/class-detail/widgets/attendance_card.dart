import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prezent/modules/faculty/controllers/class_detail_view_conroller.dart';

import '../../../../../models/models.dart';
import '../../../controllers/student_controller.dart';

class AttendanceCard extends StatelessWidget {
  const AttendanceCard({
    Key? key,
    required this.classSubjectId,
    required this.context,
    required this.forPresent,
    required this.viewController, required this.index,
  }) : super(key: key);

  final ClassSubjectIdModel classSubjectId;
  final BuildContext context;
  final bool forPresent;
  final ClassDetailViewController viewController;
  final int index;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Get.theme.colorScheme;
    List<StudentAttendanceModel> studentList =
        viewController.studentList(forPresent, index);
    return Card(
      margin: EdgeInsets.zero,
      shadowColor: colorScheme.shadow,
      elevation: 5,
      child: InkWell(
        splashColor: colorScheme.primary.withOpacity(.4),
        onTap: () {
          showStudentList(
            context,
            studentList,
          );
        },
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    forPresent ? 'Student Present' : 'Student Absent',
                    style: Get.theme.textTheme.displayMedium
                        ?.copyWith(fontSize: 16),
                  ),
                  Text(
                    '${studentList.length}',
                    style: Get.theme.textTheme.displaySmall
                        ?.copyWith(fontSize: 14),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_right,
                size: 24,
              )
            ],
          ),
        ),
      ),
    );
  }

  Future<dynamic> showStudentList(
      BuildContext context, List<StudentAttendanceModel> studentList) {
    ColorScheme colorScheme = Get.theme.colorScheme;
    return showModalBottomSheet(
      // isScrollControlled: true,
      context: context,
      builder: (ctx) => CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: colorScheme.primary.withOpacity(.2),
            pinned: true,
            forceElevated: true,
            leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: const Text(
                'X',
                style: TextStyle(
                  fontSize: 20,
                ),
              ),
            ),
            title: Text(
              forPresent ? 'Students Present' : 'Students Absent',
              style: Get.theme.textTheme.bodySmall?.copyWith(
                fontSize: 16,
                color: Get.theme.colorScheme.onPrimary,
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              ((context, index) {
                int rollNo = studentList[index].rollNo;
                return Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 8,
                    horizontal: 16,
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '$rollNo',
                        style: Get.theme.textTheme.bodySmall?.copyWith(
                          fontSize: 16,
                        ),
                      ),
                      Text(
                        StudentController().getStudentNameByrollNoclassId(
                          rollNo,
                          classSubjectId.classId,
                        ),
                        style: Get.theme.textTheme.bodySmall?.copyWith(
                          fontSize: 16,
                        ),
                      ),
                    ],
                  ),
                  //
                );
              }),
              childCount: studentList.length,
            ),
          )
        ],
      ),
    );
  }
}
