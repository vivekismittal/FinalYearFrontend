import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prezent/controllers/class_controller.dart';
import 'package:prezent/modules/common_widgets/default_loader.dart';

import '../../../data/class_data.dart';
import '../../common_widgets/form_input_field.dart';
import 'form_dialog.dart';

class CreateClassForm extends StatelessWidget {
  const CreateClassForm({
    super.key,
    required this.formKey,
    required this.courseInput,
    required this.branchInput,
    required this.sectionInput,
    required this.passingYearInput,
  });

  final GlobalKey formKey;
  final TextEditingController courseInput;
  final TextEditingController branchInput;
  final TextEditingController sectionInput;
  final TextEditingController passingYearInput;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          InputSearchableDropDownField(
            controller: courseInput,
            items: allCourses.map((e) => e.course).toList(),
            label: 'Course',
            hint: 'Select Course',
          ),
          InputSearchableDropDownField(
            controller: branchInput,
            items: allBranches.map((e) => e.branch).toList(),
            label: 'Branch',
            hint: 'Select Branch',
          ),
          FormInputField(
            controller: sectionInput,
            label: 'Section',
            hintText: 'Enter Section',
          ),
          FormInputField(
            controller: passingYearInput,
            label: 'Passing Year',
            hintText: 'Enter Passing Year',
          ),
        ],
      ),
    );
  }
}

class CreateSubjectForm extends StatelessWidget {
  const CreateSubjectForm({
    super.key,
    required this.formKey,
    required this.subjectNameInput,
    required this.subjectCodeInput,
  });

  final GlobalKey formKey;
  final TextEditingController subjectNameInput;
  final TextEditingController subjectCodeInput;

  @override
  Widget build(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          FormInputField(
            controller: subjectNameInput,
            label: 'Subject Name',
            hintText: 'Enter Subject Name',
          ),
          FormInputField(
            controller: subjectCodeInput,
            label: 'Subject Code',
            hintText: 'Enter Subject Code',
          ),
        ],
      ),
    );
  }
}


Future<void> showCreateClassOrSubjectDialog(
 
  ClassController controller,
  bool isSubject,
) async {
  showFormDialog(
    title: 'Enter New ${isSubject ? 'Subject' : 'Class'} Details',
    form: Obx(
      () => (isSubject
              ? controller.isSubjectPosting.isTrue
              : (controller.isBranchFetching.isTrue ||
                  controller.isCourseFetching.isTrue ||
                  controller.isClassPosting.isTrue))
          ? DefaultLoader(
              isLoad: (isSubject
                      ? controller.isSubjectPostingFailed
                      : controller.isClassPostingFailed)
                  .isFalse,
              retryFn:
                  isSubject ? controller.saveSubject : controller.saveClass,
            )
          : isSubject
              ? CreateSubjectForm(
                  formKey: controller.subjectFormKey,
                  subjectNameInput: controller.subjectNameInput,
                  subjectCodeInput: controller.subjectCodeInput,
                )
              : CreateClassForm(
                  formKey: controller.classFormKey,
                  courseInput: controller.courseInput,
                  branchInput: controller.branchInput,
                  sectionInput: controller.sectionInput,
                  passingYearInput: controller.passingYearInput,
                ),
    ),
    onSubmit: isSubject ? controller.saveSubject : controller.saveClass,
    onInit: () {
      if (isSubject) {
        controller.initNewSubjectForm();
      } else {
        controller.getBranches();
        controller.getCourses();
        controller.initNewClassForm();
      }
    },
  );
}
