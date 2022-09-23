
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ViewTile extends StatelessWidget {
  const ViewTile({
    Key? key,
    required this.text,
    required this.onEdit,
    required this.onRemove,
  }) : super(key: key);

  final String text;
  final bool onEdit;
  final void Function() onRemove;

  @override
  Widget build(BuildContext context) {
    ColorScheme colorScheme = context.theme.colorScheme;
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(text),
            Visibility(
              visible: onEdit,
              child: IconButton(
                  padding: const EdgeInsets.all(0),
                  icon: Icon(
                    Icons.delete_outline_rounded,
                    color: colorScheme.error,
                  ),
                  onPressed: onRemove),
            ),
          ],
        ),
      ),
    );
  }
}
