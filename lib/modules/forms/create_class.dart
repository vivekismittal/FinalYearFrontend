// import 'dart:developer';

// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:prezent/data/class_data.dart';
// import 'package:prezent/modules/common_widgets/form_input_field.dart';
// import 'package:prezent/requests/class_request.dart';

// class CreateClass extends StatelessWidget {
//   const CreateClass({
//     super.key,
//     // required this.homeViewController,
//   });
//   // final HomeViewController homeViewController;
//   // final FacultyController facultyController = FacultyController();
//   @override
//   Widget build(BuildContext context) {
//     RxBool isFormSubmitted = false.obs;
//     final _formKey = GlobalKey<FormState>(debugLabel: 'create-class');
//     ClassRequest classRequest = ClassRequest();
//     // classRequest.fetchAllCoursesAndBranches();
//     ColorScheme colorScheme = Get.theme.colorScheme;
//     return SafeArea(
//       child: Scaffold(
//         body: CustomScrollView(
//           slivers: [
//             SliverAppBar(
//               title: const Text('Add New Class'),
//               leading: IconButton(
//                 icon: const Icon(
//                   Icons.arrow_back_ios_new_outlined,
//                 ),
//                 onPressed: Get.back,
//               ),
//             ),
//             SliverList(
//               delegate: SliverChildListDelegate(
//                 [
//                   Form(
//                     key: _formKey,
//                     autovalidateMode: AutovalidateMode.onUserInteraction,
//                     child: Obx(
//                       () => classRequest.isFetchingCoursesAndBranches.isTrue
//                           ? const Text('loading.....')
//                           : Padding(
//                               padding: const EdgeInsets.all(16.0),
//                               child: Column(
//                                 children: [
//                                   InputSearchableDropDownField(
//                                     controller: TextEditingController(),
//                                     label: 'Select Course',
//                                     hint: 'None',
//                                     items: allCourses,
//                                   ),
//                                   // InputSearchableDropDownField(
//                                   //   controller: TextEditingController(),
//                                   //   label: 'Select Branch',
//                                   //   hint: 'None',
//                                   //   items: allBranches,
//                                   // ),
//                                   Obx(
//                                     () {
//                                       return ActionChip(
//                                         backgroundColor: isFormSubmitted.isTrue
//                                             ? colorScheme.secondary
//                                             : colorScheme.tertiary,
//                                         labelStyle: TextStyle(
//                                           color: isFormSubmitted.isTrue
//                                               ? colorScheme.tertiary
//                                               : colorScheme.secondary,
//                                         ),
//                                         onPressed: () {
//                                           // if (_formKey.currentState!.validate()) {
//                                           //   facultyController.addNewFacultyClass(
//                                           //     homeViewController,
//                                           //     facultyController.subjectCodeController,
//                                           //     facultyController.controller,
//                                           //   );

//                                           //   isFormSubmitted(true);
//                                           //   Future.delayed(
//                                           //     const Duration(seconds: 1),
//                                           //     () => Get.back(),
//                                           //   );
//                                           // } else {
//                                           //   log('Validation ERROR');
//                                           // }
//                                         },
//                                         label: Text(isFormSubmitted.isFalse
//                                             ? 'Save'
//                                             : 'Saved'),
//                                       );
//                                     },
//                                   ),
//                                 ],
//                               ),
//                             ),
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
