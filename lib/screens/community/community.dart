import 'package:demo/widget/questionItem_component.dart';
import 'package:flutter/material.dart';

class CommunityScreen extends StatelessWidget {
  final List<bool> isSelected = [false, true];

  CommunityScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: 10, // Example count
              itemBuilder: (context, index) {
                return QuestionCard();
              },
            ),
          ),
        ],
      ),
    );
  }
}
