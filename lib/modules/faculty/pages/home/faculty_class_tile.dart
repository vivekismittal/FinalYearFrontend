import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:prezent/modules/faculty/pages/class-detail/class_detail_view.dart';

import '../../../../models/models.dart';

class FacultyClassTile extends StatelessWidget {
  const FacultyClassTile({
    super.key,
    required this.classSubjectId,
  });
  final ClassSubjectIdModel classSubjectId;

  @override
  Widget build(BuildContext context) {
    return Card(
      child: InkWell(
        splashColor: Get.theme.colorScheme.primary.withOpacity(.4),
        onTap: () => Get.to(
          () => ClassDetailView(
            classSubjectId: classSubjectId,
          ),
          transition: Transition.cupertino,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(
                      text: classSubjectId.classId,
                      style: Theme.of(context).textTheme.bodyMedium,
                      children: [
                        TextSpan(
                          text: '  (${classSubjectId.subjectCode})',
                          style: Theme.of(context).textTheme.bodySmall,
                        ),
                      ],
                    ),
                  ),
                  Text(
                    '${classSubjectId.noOfStudent} students',
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
