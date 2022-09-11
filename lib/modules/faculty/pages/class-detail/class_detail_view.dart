import 'package:flutter/material.dart';
import 'package:get/get.dart';
// import 'package:lottie/lottie.dart';
import 'package:prezent/modules/faculty/controllers/class_detail_view_conroller.dart';
import 'package:prezent/modules/faculty/pages/class-detail/widgets/time_slots_widget.dart';
import './widgets/attendance_calender.dart';

import '../../../../models/models.dart';

class ClassDetailView extends StatelessWidget {
  const ClassDetailView({super.key, required this.classSubjectId});
  final ClassSubjectIdModel classSubjectId;
  @override
  Widget build(BuildContext context) {
    ClassDetailViewController controller = Get.put(ClassDetailViewController(classSubjectId));
    
    ColorScheme colorScheme = Get.theme.colorScheme;
    return SafeArea(
      top: false,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              leading: IconButton(
                icon: const Icon(Icons.arrow_back_ios_new_outlined),
                onPressed: () => Get.back(),
              ),
              title: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(classSubjectId.classId),
                  Text(
                    classSubjectId.subjectCode,
                    style: Get.textTheme.bodySmall?.copyWith(
                      color: Get.theme.colorScheme.onSecondary,
                      fontSize: 16,
                    ),
                  ),
                ],
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  AttendanceCalender(
                    viewController: controller,
                    classSubjectId: classSubjectId,
                  ),
                  GetBuilder<ClassDetailViewController>(
                    id: 'ClassDetailView-$classSubjectId',
                    key: ValueKey('ClassDetailView-$classSubjectId'),
                    builder: (controller) {
                      return Column(
                        children: [
                          controller.isRecordAvailable
                              ? Padding(
                                  padding: const EdgeInsets.all(8.0),
                                  child: TimeSlotWidget(
                                    classSubjectId: classSubjectId,
                                    context: context,
                                    viewController: controller,
                                  ),
                                )
                              : const Center(
                                  child: Text('No Lecture found'),
                                ),
                          // Spacer(),
                          Visibility(
                            visible: controller.isToday,
                            child: ActionChip(
                              label: Text(
                                'Start new Lecture',
                                style: Get.textTheme.displaySmall?.copyWith(
                                  color: colorScheme.onSecondary,
                                ),
                              ),
                              backgroundColor:
                                  colorScheme.secondary.withOpacity(.5),
                              onPressed: () {},
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
