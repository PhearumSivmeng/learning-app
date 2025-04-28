import 'package:demo/widget/learnItem_component.dart';
import 'package:flutter/material.dart';

class CourseScreen extends StatelessWidget {
  const CourseScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Container(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: [
              LearnCard(),
            ],
          ),
        ),
      ),
    );
  }
}
