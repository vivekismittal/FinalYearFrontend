import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prezent/data/class_data.dart';
import 'package:prezent/models/dummy_data.dart';
import 'package:prezent/models_2.dart/course_branch.dart';

class FormInputField extends StatelessWidget {
  const FormInputField({
    Key? key,
    required this.controller,
    required this.label,
    this.textInputAction = TextInputAction.next,
    this.prefixWidget,
    this.suffixWidget,
    this.trailingWidget,
    this.canExpand = false,
    this.errorText = 'Required field',
    this.hintText,
    this.onChanged,
  }) : super(key: key);

  final TextEditingController controller;
  final String label;
  final TextInputAction textInputAction;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Widget? trailingWidget;
  final bool canExpand;
  final String? errorText;
  final String? hintText;
  final Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Get.theme.colorScheme;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            trailingWidget ?? const SizedBox(),
          ],
        ),
        // verticalSpacing(),
        ConstrainedBox(
          constraints: const BoxConstraints(
            maxHeight: 120,
            minHeight: 60,
          ),
          child: TextFormField(
            controller: controller,
            validator: (value) {
              print('value: $value  ');

              if ((value == null || value.isEmpty)) {
                return 'Required Field';
              }
              if (label == 'Class Id') {
                if (dummyClasses
                    .where((element) => element.classId == value)
                    .isEmpty) {
                  return 'Class Id not Found';
                }
              }
              if (label == 'Add Branch') {
                print(label);

                for (var element in allBranches) {
                  if (element.branch == value) {
                    return 'Branch Already Added';
                  }
                }
              }
              if (label == 'Add Course') {
                print(label);

                for (var element in allCourses) {
                  if (element.course == value) {
                    return 'Course Already Added';
                  }
                }
              }
              
              return null;
            },
            // if (label == 'Username') {
            //   if (value.length < 8) {
            //     return 'Username should be atleast length of 8';
            //   }
            //   if (value.length > 30) {
            //     return 'Username should be atmost length of 30';
            //   }
            //   if (!AppValues.userValidationRegEx.hasMatch(value)) {
            //     if (RegExp(r"^[_0-9]").hasMatch(value)) {
            //       return 'Username must begin with alphabets';
            //     } else {
            //       return 'Valid only alphabets,numbers and underscore';
            //     }
            //   }
            // }

            cursorColor: colorScheme.onSurface,
            cursorHeight: 24,
            autofocus: false,
            enableSuggestions: true,
            enableInteractiveSelection: true,
            maxLines: canExpand == false ? 1 : 4,
            minLines: 1,
            style: Get.textTheme.bodySmall,
            textInputAction: textInputAction,
            onChanged: onChanged,
            maxLength: 56,
            decoration: InputDecoration(
              label: Text(label),
              hintText: hintText,
              prefixIcon: prefixWidget,
              prefixIconColor: colorScheme.onSurface,
              prefixIconConstraints: const BoxConstraints(
                maxWidth: 16,
                maxHeight: 16,
              ),
              suffixIcon: suffixWidget,
              suffixIconColor: colorScheme.onSurface,
              suffixIconConstraints: const BoxConstraints(
                maxWidth: 16,
                maxHeight: 16,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class InputSearchableDropDownField extends StatelessWidget {
  const InputSearchableDropDownField({
    Key? key,
    required this.controller,
    required this.items,
    required this.label,
    required this.hint,
    this.showSearchBox = true,
  }) : super(key: key);

  final TextEditingController controller;
  final List<String> items;
  final String label;
  final String hint;
  final bool showSearchBox;

  @override
  Widget build(BuildContext context) {
    return DropdownSearch<String>(
      popupProps: PopupProps.menu(
        scrollbarProps: const ScrollbarProps(),
        showSearchBox: showSearchBox,
        searchFieldProps: const TextFieldProps(autofocus: true),
        searchDelay: const Duration(),
      ),
      items: items,
      autoValidateMode: AutovalidateMode.onUserInteraction,
      onChanged: (value) => controller.text = value!,
      validator: (value) {
        if ((value == null || value.isEmpty)) {
          return '$label can\'t be empty';
        }
        return null;
      },
      dropdownDecoratorProps: DropDownDecoratorProps(
        dropdownSearchDecoration: InputDecoration(
          labelText: label,
          hintText: hint,
        ),
      ),
    );
  }
}
