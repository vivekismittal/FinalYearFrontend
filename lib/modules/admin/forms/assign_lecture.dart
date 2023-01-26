import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prezent/controllers/class_controller.dart';
import 'package:prezent/controllers/faculty_controller.dart';
import 'package:prezent/modules/admin/forms/form_dialog.dart';
import 'package:prezent/modules/common_widgets/default_loader.dart';

import '../../common_widgets/form_input_field.dart';

Future<void> assigningLectureForm(
  FacultyController controller,
  String email,
) async {
  ClassController classController = Get.put(ClassController());
  classController.getClasses();
  classController.getSubjects();
  showFormDialog(
    title: 'Create New Lecture',
    form: Obx(
      () {
        List<String> classIds = [], subjectCodes = [];
        if (classController.isClassFetching.isFalse &&
            classController.isSubjectFetching.isFalse) {
          classIds = classController.getClassIds;
          subjectCodes = classController.getsubjectCodes;
        }

        return (classController.isClassFetching.isTrue ||
                classController.isSubjectFetching.isTrue)
            ? DefaultLoader(
                isLoad: true,
                retryFn: () {},
              )
            : (controller.isFacultyLecturesAssigning[email]!.isTrue)
                ? DefaultLoader(
                    isLoad: controller
                        .isFacultyLecturesAssigningFailed[email]!.isFalse,
                    retryFn: () => controller.assignLecture(email),
                  )
                : Form(
                    child: Column(
                      children: [
                        InputSearchableDropDownField(
                          controller: controller.classIdInput,
                          items: classIds,
                          label: 'Lecture Class',
                          hint: 'Select ClassId',
                        ),
                        InputSearchableDropDownField(
                          controller: controller.subjectCodeInput,
                          items: subjectCodes,
                          label: 'Lecture Subject',
                          hint: 'Select Subject Code',
                        ),
                      ],
                    ),
                  );
      },
    ),
    onSubmit: () => controller.assignLecture(email),
    onInit: () => controller.initAssignLectureForm(email),
  );
}
