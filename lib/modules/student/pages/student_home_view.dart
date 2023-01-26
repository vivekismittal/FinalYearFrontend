import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prezent/controllers/student_controller.dart';
import 'package:prezent/data/student_data.dart';
import 'package:prezent/data/user_data.dart';
import 'package:prezent/modules/student/forms/student_registration_form.dart';
import 'package:prezent/modules/student/pages/my_lectures_view.dart';

class StudentHomeView extends StatelessWidget {
  const StudentHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    StudentController controller = Get.put(StudentController());
    if (activeUser.isRegistered) {
      controller.getStudent();
    }
    return SafeArea(
      child: Scaffold(
        body: GetBuilder<StudentController>(
            id: 'Student-View',
            key: const ValueKey('Student-View'),
            builder: (controller) {
              return CustomScrollView(
                slivers: [
                  SliverAppBar(
                    title: Text(
                      'hi, ${activeUser.name}',
                      style: const TextStyle(fontSize: 16),
                    ),
                    pinned: true,
                    automaticallyImplyLeading: false,
                    actions: [
                      TextButton(
                        onPressed: () => Get.to(() => const MyLectures()),
                        child: const Text('My Lectures'),
                      ),
                    ],
                  ),
                  SliverList(
                    delegate: SliverChildListDelegate(
                      [
                        const SizedBox(
                          height: 200,
                        ),
                        if (!activeUser.isRegistered)
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: () {
                                  oneTimeRegistrationForm(
                                      controller);
                                },
                                child: const Text(
                                    'Please Register Yourself First'),
                              ),
                            ],
                          ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      ),
    );
  }
}
