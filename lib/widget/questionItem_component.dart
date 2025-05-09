import 'dart:math';

import 'package:demo/data/models/question_model.dart';
import 'package:flutter/material.dart';

class QuestionCard extends StatelessWidget {
  final int? answer;
  final String? title;
  final String? description;
  final String? user;
  final String? profile;
  final List<Tag>? tags;

  const QuestionCard({
    super.key,
    this.answer,
    this.title,
    this.description,
    this.user,
    this.profile,
    this.tags,
  });

  @override
  Widget build(BuildContext context) {
    final random = Random();
    int randomNumber = random.nextInt(60);
    return Padding(
      padding: const EdgeInsets.all(5.0),
      child: Card(
        color: Colors.white,
        margin: const EdgeInsets.symmetric(horizontal: 8.0, vertical: 4.0),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Row(
                    children: [
                      Icon(Icons.chat_bubble_outline,
                          size: 16, color: Colors.grey),
                      SizedBox(width: 4),
                      Text('$answer answers'),
                    ],
                  ),
                  IconButton(
                    icon: const Icon(Icons.more_vert),
                    onPressed: () {},
                  ),
                ],
              ),
              const SizedBox(height: 8),
              Text(
                '$title',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
              ),
              const SizedBox(height: 8),
              Text(
                '$description',
                style: TextStyle(color: Colors.grey[700]),
                overflow: TextOverflow.ellipsis,
                maxLines: 2,
              ),
              const SizedBox(height: 8),
              Wrap(
                spacing: 4.0,
                runSpacing: 4.0,
                children:
                    tags!.map((tag) => Chip(label: Text(tag.tagName))).toList(),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  CircleAvatar(
                    radius: 15,
                    backgroundImage: NetworkImage(profile!
                        .replaceAll('192.168.70.70:8080', '10.0.2.2:8000')),
                  ),
                  SizedBox(width: 8),
                  Text(user!,
                      style:
                          TextStyle(fontSize: 12, fontWeight: FontWeight.bold)),
                  Spacer(),
                  Text('asked ${randomNumber} min ago',
                      style: TextStyle(fontSize: 12, color: Colors.grey)),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
