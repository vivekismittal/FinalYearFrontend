import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prezent/models/dummy_data.dart';
import 'package:prezent/modules/faculty/controllers/faculty_controller.dart';
import 'package:prezent/modules/faculty/controllers/home_view_controller.dart';
import 'package:prezent/modules/common_widgets/form_input_field.dart';

class AddNewFacultyClassView extends StatelessWidget {
  AddNewFacultyClassView({
    super.key,
    required this.homeViewController,
  });
  final HomeViewController homeViewController;
  final FacultyController facultyController = FacultyController();
  @override
  Widget build(BuildContext context) {
    RxBool isFormSubmitted = false.obs;
    final _formKey = GlobalKey<FormState>();

    ColorScheme colorScheme = Get.theme.colorScheme;
    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Add New Class'),
              leading: IconButton(
                icon: const Icon(
                  Icons.arrow_back_ios_new_outlined,
                ),
                onPressed: Get.back,
              ),
            ),
            SliverList(
              delegate: SliverChildListDelegate(
                [
                  Form(
                    key: _formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          InputSearchableDropDownField(
                            controller:
                                facultyController.classIdController,
                            label: 'Class Id',
                            hint: 'format:- "branch-section"',
                            items: dummyClassId,
                          ),
                          InputSearchableDropDownField(
                            controller:
                                facultyController.subjectCodeController,
                            hint: 'Enter the Subject Code',
                            label: 'Subject Code',
                            items: dummySubjects,
                          ),
                          Obx(
                            () {
                              return ActionChip(
                                backgroundColor: isFormSubmitted.isTrue
                                    ? colorScheme.secondary
                                    : colorScheme.tertiary,
                                labelStyle: TextStyle(
                                  color: isFormSubmitted.isTrue
                                      ? colorScheme.tertiary
                                      : colorScheme.secondary,
                                ),
                                onPressed: () {
                                  if (_formKey.currentState!.validate()) {
                                    facultyController.addNewFacultyClass(
                                      homeViewController,
                                      facultyController.subjectCodeController,
                                      facultyController.classIdController,
                                    );

                                    isFormSubmitted(true);
                                    Future.delayed(
                                      const Duration(seconds: 1),
                                      () => Get.back(),
                                    );
                                  } else {
                                    log('Validation ERROR');
                                  }
                                },
                                label: Text(
                                    isFormSubmitted.isFalse ? 'Save' : 'Saved'),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
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
