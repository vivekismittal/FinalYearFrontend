import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:prezent/modules/admin/admin_home_view.dart';
import 'package:prezent/modules/forms/create_new_user.dart';
import 'package:prezent/modules/student/pages/home_view/home_view.dart';
import './modules/faculty/pages/home/home_view.dart';
import './utils/app_theme.dart';
import 'modules/forms/create_class.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((_) {
    runApp(const MyApp());
  });
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: AppTheme().themeData,
      home: const FirstView(),
      debugShowCheckedModeBanner: false,
      // initialBinding: GlobalBindings(),
    );
  }
}

class FirstView extends StatelessWidget {
  const FirstView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            userChip(
              'Student',
              () => Get.to(const StudentHomeView()),
            ),
            const SizedBox(
              height: 16,
            ),
            userChip(
              'Faculty',
              () => Get.to(() => const FacultyHomeView()),
            ),
            const SizedBox(
              height: 16,
            ),
            userChip('Admin', () => Get.to(() => const AdminHomeView())),
            const SizedBox(
              height: 16,
            ),
            userChip(
              'Create new User',
              () => Get.to(() => const CreateNewUserForm()),
            ),
          ],
        ),
      ),
    );
  }

  ActionChip userChip(String user, void Function() onTap) {
    return ActionChip(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
      label: Text(
        user,
        style: Get.textTheme.titleLarge,
      ),
      onPressed: onTap,
    );
  }
}
