import 'package:flutter/material.dart';
import 'package:get/get.dart';

class StudentSubjectsTile extends StatelessWidget {
  const StudentSubjectsTile(
      {super.key, required this.subject, required this.faculty});
  final String subject;
  final String faculty;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Get.theme.colorScheme.primary.withOpacity(.4),
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    subject,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  Text(
                    faculty,
                    style: Theme.of(context)
                        .textTheme
                        .bodySmall
                        ?.copyWith(fontSize: 14),
                  ),
                ],
              ),
              const Icon(
                Icons.arrow_forward_ios_outlined,
                size: 24,
              )
            ],
          ),
        ),
      ),
    );
  }
}
