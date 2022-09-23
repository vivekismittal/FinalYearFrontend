import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:prezent/data/class_data.dart';
import 'package:prezent/modules/admin/widgets/view_tile.dart';

import '../../../controllers/class_controller.dart';

class ClassesView extends StatelessWidget {
  ClassesView({super.key});

  ClassController controller = Get.put(ClassController());
  bool onEdit = false;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.theme.colorScheme;
    if (!isClassFetched) {
      controller.lastFn = controller.getClasses;
      controller.getClasses();
    }
    return SafeArea(
        child: Scaffold(
      body: GetBuilder<ClassController>(
          id: 'All-Class-View',
          key: const ValueKey('All-Class-View'),
          builder: (controller) {
            return CustomScrollView(
              slivers: [
                SliverAppBar(
                  title: const Text('All Classes'),
                  leading: IconButton(
                    icon: const Icon(
                      Icons.arrow_back_ios_new_outlined,
                    ),
                    onPressed: Get.back,
                  ),
                  actions: [
                    TextButton(
                      onPressed: () {},
                      child: Text(
                        onEdit ? 'Save' : 'Edit',
                      ),
                    ),
                  ],
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Obx(
                        () => Column(
                          children: controller.isClassFetching.isFalse
                              ? List.generate(
                                  allClasses.length,
                                  (index) => ViewTile(
                                    text: allClasses[index].classId,
                                    onEdit: onEdit,
                                    onRemove: () {},
                                  ),
                                )
                              : [
                                  LottieBuilder.asset(
                                    'lottieFiles/pixel-loader.json',
                                    height: 300,
                                    frameRate: FrameRate.max,
                                    animate: controller.isClassFailed.isFalse,
                                  ),
                                  Visibility(
                                    visible: controller.isClassFailed.isTrue,
                                    child: IconButton(
                                      onPressed: controller.lastFn,
                                      icon: Icon(
                                        Icons.replay_circle_filled_outlined,
                                        color: colorScheme.error,
                                        semanticLabel: 'Retry',
                                        size: 30,
                                      ),
                                    ),
                                  )
                                ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            );
          }),
    ));
  }
}
