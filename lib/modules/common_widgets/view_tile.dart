import 'package:flutter/material.dart';

class ViewTile extends StatelessWidget {
  const ViewTile({
    Key? key,
    required this.title,
    this.action,
  }) : super(key: key);

  final Widget title;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(8),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            title,
            if (action != null) action!,
          ],
        ),
      ),
    );
  }
}
