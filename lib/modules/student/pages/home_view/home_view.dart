import 'package:flutter/material.dart';
class StudentHomeView extends StatelessWidget {
  const StudentHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Scaffold(
        body: CustomScrollView(
          slivers: [
            SliverAppBar(
              title: Text(
                'Your Subjects',
              ),
              pinned: true,
              automaticallyImplyLeading: false,
            ),
          ],
        ),
      ),
    );
  }
}
