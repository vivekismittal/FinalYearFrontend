// import 'dart:html';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prezent/modules/faculty/controllers/class_detail_view_conroller.dart';
import 'package:prezent/modules/faculty/pages/class-detail/widgets/attendance_card.dart';

import '../../../../../models/models.dart';

class TimeSlotWidget extends StatelessWidget {
  TimeSlotWidget({
    Key? key,
    required this.classSubjectId,
    required this.context,
    required this.viewController,
  }) : super(key: key);

  final ClassSubjectIdModel classSubjectId;
  final BuildContext context;
  final ClassDetailViewController viewController;
  late List<bool> activeStatusList;
  ColorScheme colorScheme = Get.theme.colorScheme;
  @override
  Widget build(BuildContext context) {
    activeStatusList = List.filled(viewController.timeSlots().length, false);

    // List<StudentAttendanceModel> studentList =
    //     viewController.studentList(forPresent, 0);
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Attendance',
              style: Get.theme.textTheme.displayMedium,
            ),
            Text(
              'Total Student : ${viewController.totalNoOfStudent}',
              style: Get.theme.textTheme.bodySmall?.copyWith(fontSize: 16),
            ),
          ],
        ),
        const SizedBox(
          height: 8,
        ),
        GetBuilder<ClassDetailViewController>(
          id: 'Wrapped-timeSlots',
          key: ValueKey('Wrapped-timeSlots-$classSubjectId'),
          builder: (controller) {
            return Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              children: List.generate(
                activeStatusList.length,
                (index) => slotWidget(index),
              ),
            );
          },
        )
      ],
    );
  }

  Column slotWidget(int index) {
    return Column(
      children: [
        ActionChip(
          side: BorderSide(
            color: activeStatusList[index]
                ? colorScheme.onPrimary.withOpacity(.5)
                : colorScheme.onBackground.withOpacity(.1),
          ),
          labelStyle: TextStyle(
            color: colorScheme.onBackground.withOpacity(.5),
          ),
          backgroundColor: activeStatusList[index]
              ? colorScheme.primary.withOpacity(.5)
              : colorScheme.background.withOpacity(.2),
          padding: const EdgeInsets.all(4),
          label: Text(
            viewController.getTimeSlot(index),
          ),
          onPressed: () {
            for (int i = 0; i < activeStatusList.length; i++) {
              activeStatusList[i] = i == index ? !activeStatusList[i] : false;
            }

            Future.delayed(
              const Duration(milliseconds: 100),
              () {
                viewController.updateWrappedTimeSlots();
              },
            );
          },
        ),
        Visibility(
          visible: activeStatusList[index],
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              AttendanceCard(
                classSubjectId: classSubjectId,
                context: context,
                viewController: viewController,
                forPresent: true,
                index: index,
              ),
              AttendanceCard(
                classSubjectId: classSubjectId,
                context: context,
                viewController: viewController,
                forPresent: false,
                index: index,
              ),
            ],
          ),
        )
      ],
    );
  }
}
