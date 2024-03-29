import 'dart:developer';

import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prezent/data/class_data.dart';
import 'package:prezent/models/dummy_data.dart';

class FormInputField extends StatelessWidget {
  const FormInputField(
      {Key? key,
       this.controller,
      required this.label,
      this.textInputAction = TextInputAction.next,
      this.prefixWidget,
      this.suffixWidget,
      this.trailingWidget,
      this.canExpand = false,
      this.errorText = 'Required field',
      this.hintText,
      this.onChanged,
      this.autoFocus = false,
      this.isReadOnly = false,
      this.intialValue = ''})
      : super(key: key);

  final TextEditingController? controller;
  final String label;
  final TextInputAction textInputAction;
  final Widget? prefixWidget;
  final Widget? suffixWidget;
  final Widget? trailingWidget;
  final bool canExpand;
  final String? errorText;
  final String? hintText;
  final Function(String)? onChanged;
  final bool autoFocus;
  final bool isReadOnly;
  final String intialValue;
  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = Get.theme.colorScheme;
    return !isReadOnly
        ? ConstrainedBox(
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
              cursorHeight: 24,
              autofocus: autoFocus,
              enableSuggestions: true,
              enableInteractiveSelection: true,
              maxLines: canExpand == false ? 1 : 4,
              minLines: 1,
              style: Get.textTheme.bodySmall,
              textInputAction: textInputAction,
              onChanged: onChanged,
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
          )
        : ConstrainedBox(
            constraints: const BoxConstraints(
              maxHeight: 120,
              minHeight: 60,
            ),
            child: TextFormField(
              readOnly: true,
              initialValue: intialValue,
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
    this.showSearchBox = false,
  }) : super(key: key);

  final TextEditingController controller;
  final List<String> items;
  final String label;
  final String hint;
  final bool showSearchBox;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        maxHeight: 120,
        minHeight: 60,
      ),
      child: DropdownSearch<String>(
        popupProps: PopupProps.menu(
          showSearchBox: showSearchBox,
          listViewProps: ListViewProps(semanticChildCount: items.length),
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
      ),
    );
  }
}
