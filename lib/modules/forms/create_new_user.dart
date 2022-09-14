import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_connect/http/src/utils/utils.dart';
import 'package:lottie/lottie.dart';
import 'package:prezent/models/user_model.dart';
import 'package:prezent/modules/common_widgets/form_input_field.dart';
import 'package:prezent/requests/user_request.dart';

class CreateNewUserForm extends StatelessWidget {
  const CreateNewUserForm({super.key});

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Get.theme.colorScheme;

    UserController userInputController = UserController();

    var formKey = GlobalKey<FormState>(debugLabel: 'create-new-user');

    return SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: const Text('Add New User'),
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
                    key: formKey,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        children: [
                          FormInputField(
                            controller: userInputController.name,
                            label: 'Name',
                            hintText: 'Enter the Name',
                          ),
                          FormInputField(
                            controller: userInputController.email,
                            label: 'Email',
                            hintText: 'Enter the Email',
                          ),
                          FormInputField(
                            controller: userInputController.mobile,
                            label: 'Mobile',
                            hintText: 'Enter the Mobile Number',
                          ),
                          InputSearchableDropDownField(
                            controller: userInputController.role,
                            items: const ['STUDENT', 'FACULTY', 'ADMIN'],
                            label: 'Role',
                            hint: 'Tell Your Role',
                            showSearchBox: false,
                          ),
                          const SizedBox(
                            height: 50,
                          ),
                          Obx(
                            () {
                              return !userInputController
                                      .isUserCreationPending.value
                                  ? ActionChip(
                                      backgroundColor: colorScheme.secondary,
                                      labelStyle: TextStyle(
                                        color: colorScheme.tertiary,
                                      ),
                                      onPressed: () => userInputController
                                          .createNewUser(formKey),
                                      label: const Text(
                                        'Save',
                                      ),
                                    )
                                  : LottieBuilder.asset(
                                      'lottieFiles/pixel-loader.json',
                                      height: 100,
                                      frameRate: FrameRate.max,
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

class UserController {
  final TextEditingController name = TextEditingController();
  TextEditingController email = TextEditingController();
  TextEditingController mobile = TextEditingController();
  TextEditingController role = TextEditingController();
  RxBool isUserCreationPending = false.obs;

  void createNewUser(GlobalKey<FormState> formKey) async {
    if (formKey.currentState!.validate()) {
      isUserCreationPending(true);
      User newUser = User(
        name: name.text,
        email: email.text,
        mobile: int.parse(mobile.text),
        role: role.text,
      );
      bool isPosted = await UserRequest().postNewUser(newUser);
      Future.delayed(const Duration(seconds: 5), () {
        isUserCreationPending(false);
        if (isPosted) {
          formKey.currentState!.reset();
        } else {
          print('Validation ERROR');
        }
      });
    }
  }
}
