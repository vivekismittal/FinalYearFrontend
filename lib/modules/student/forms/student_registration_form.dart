import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prezent/controllers/class_controller.dart';
import 'package:prezent/data/user_data.dart';
import 'package:prezent/modules/common_widgets/default_loader.dart';

import '../../../controllers/student_controller.dart';
import '../../common_widgets/form_input_field.dart';

Future<void> oneTimeRegistrationForm(
  StudentController studentController,
) async {
    ClassController classController = Get.put(ClassController());
  classController.getClasses();
  studentController.initStudentRegisterForm();
  ColorScheme colorScheme = Get.theme.colorScheme;
  return Get.defaultDialog(
    title: 'Please Enter the details',
    backgroundColor: colorScheme.tertiary,
    content: Obx(
      () {
        List<String> classIdList = [];

        if (classController.isClassFetching.isFalse) {
          classIdList = classController.getClassIds;
        }
        return (classController.isClassFetching.isTrue ||
                studentController.isStudentRegistering.isTrue)
            ? DefaultLoader(
                isLoad: classController.isClassFailed.isFalse ||
                    studentController.isStudentRegisteringFailed.isFalse,
                retryFn: classController.getClasses,
              )
            : Form(
                key: studentController.registrationFormKey,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    FormInputField(
                      autoFocus: true,
                      label: 'Email',
                      isReadOnly: true,
                      intialValue: activeUser.email,
                    ),
                    FormInputField(
                      controller: studentController.rollNoInput,
                      label: 'Roll No',
                    ),
                    FormInputField(
                      controller: studentController.studentNoInput,
                      label: 'Student No',
                    ),
                    InputSearchableDropDownField(
                      controller: studentController.classIdInput,
                      hint: 'Select Class Id',
                      label: 'Class Id',
                      items: classIdList,
                    )
                  ],
                ),
              );
      },
    ),
    actions: [
      ElevatedButton(
        onPressed: studentController.register,
        child: const Text('Create'),
      ),
    ],
  );
}
