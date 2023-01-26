import 'package:flutter/material.dart';
import 'package:get/get.dart';

Future<void> showFormDialog({
  required String title,
  String submitText = 'Create',
  required Widget form,
  required void Function() onSubmit,
  required void Function() onInit,
}) async {
  onInit();

  ColorScheme colorScheme = Get.theme.colorScheme;

  return Get.defaultDialog(
    backgroundColor: colorScheme.tertiary,
    title: title,
    content: form,
    actions: [
      ElevatedButton(
        onPressed: onSubmit,
        child: Text(submitText),
      ),
    ],
  );
}
