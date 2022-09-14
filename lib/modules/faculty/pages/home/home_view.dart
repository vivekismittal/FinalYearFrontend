import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prezent/modules/faculty/controllers/home_view_controller.dart';
import 'package:prezent/modules/faculty/pages/add_new_faculty_class/add_new_faculty_class_view.dart';

import '../../../../models/dummy_data.dart';
import 'widgets/faculty_class_tile.dart';

class FacultyHomeView extends StatelessWidget {
  const FacultyHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    HomeViewController homeController = Get.put(HomeViewController());

    return SafeArea(
      top: false,
      maintainBottomViewPadding: true,
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            const SliverAppBar(
              title: Text(
                'Your Classes',
              ),
              pinned: true,
              automaticallyImplyLeading: false,
            ),
            GetBuilder<HomeViewController>(
              id: 'home-view',
              key: const ValueKey('home-view'),
              builder: (controller) {
                return SliverList(
                  delegate: SliverChildBuilderDelegate(
                    childCount: dummyFaculty.classRooms.length,
                    (context, index) => FacultyClassTile(
                      classSubjectId: dummyFaculty.classRooms[index].classSubjectId,
                    ),
                  ),
                );
              }
            ),
          ],
        ),
        floatingActionButton: ActionChip(
          backgroundColor: Get.theme.primaryColor.withOpacity(.5),
          label: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Add new Class',
                style: TextStyle(color: Get.theme.colorScheme.secondary),
              ),
              Icon(
                Icons.add,
                color: Get.theme.colorScheme.secondary,
                size: 22,
              ),
            ],
          ),
          onPressed: () => Get.to(
            () =>  AddNewFacultyClassView(homeViewController: homeController,),
          ),
        ),
      ),
    );
  }
}
