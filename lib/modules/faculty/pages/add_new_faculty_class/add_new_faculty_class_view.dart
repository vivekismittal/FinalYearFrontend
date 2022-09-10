import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prezent/form_input_field.dart';
import 'package:prezent/modules/faculty/controllers/faculty_controller.dart';
import 'package:prezent/modules/faculty/controllers/home_view_controller.dart';

class AddNewFacultyClassView extends StatelessWidget {
  AddNewFacultyClassView({
    super.key,
    required this.homeViewController,
  });
  final HomeViewController homeViewController;
  final FacultyController facultyController = FacultyController();
  @override
  Widget build(BuildContext context) {
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
                  autovalidateMode: AutovalidateMode.onUserInteraction,
                  child: Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: Column(
                      children: [
                        // TextFormField(
                        //   decoration: const InputDecoration(
                        //     hintText: 'Class Id',
                        //   ),
                        // ),
                        // TextFormField(
                        //   decoration: const InputDecoration(
                        //     hintText: 'SUbject Code',
                        //   ),
                        // ),
                        FormInputField(
                          controller: facultyController.classIdController,
                          label: 'Class Id',
                        ),
                        FormInputField(
                          controller: facultyController.subjectCodeController,
                          label: 'Subject Code',
                        ),
                        MaterialButton(
                          onPressed: () {
                            facultyController.addNewFacultyClass(
                              homeViewController,
                              facultyController.subjectCodeController,
                              facultyController.classIdController,
                            );
                          },
                          child: Text('Save'),
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
    ));
  }
}
