import 'dart:math';

import 'package:flutter/material.dart';

class LearnCard extends StatelessWidget {
  final String title;
  final String thumbnail;
  final int views;
  final String profileInstructor;
  final String instructor;

  const LearnCard({
    super.key,
    required this.title,
    required this.thumbnail,
    required this.views,
    required this.profileInstructor,
    required this.instructor,
  });

  @override
  Widget build(BuildContext context) {
    final random = Random();
    int randomNumber = random.nextInt(60);

    return Card(
      color: Colors.white,
      elevation: 4,
      margin: const EdgeInsets.all(12),
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding inside the Card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage: NetworkImage(profileInstructor.replaceAll(
                      '192.168.70.70:8080', '10.0.2.2:8000')),
                  radius: 20,
                ),
                const SizedBox(width: 8),
                Text(
                  instructor,
                  style: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 12),
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                thumbnail.replaceAll('192.168.70.70:8080', '10.0.2.2:8000'),
                height: 180,
                width: double.infinity,
                fit: BoxFit.cover,
              ),
            ),
            const SizedBox(height: 12),
            Text(
              title,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const SizedBox(height: 6),
            Text('$views views'),
            const SizedBox(height: 12),
            Row(
              children: [
                ElevatedButton.icon(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                        vertical: 10,
                        horizontal: 20,
                      ),
                    ),
                    onPressed: () {},
                    icon: const Icon(
                      Icons.play_arrow,
                      color: Colors.white,
                    ),
                    label: const Text(
                      'Watch Now',
                      style: TextStyle(
                        color: Colors.white,
                      ),
                    )),
                const SizedBox(width: 8),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey.shade400,
                    padding: const EdgeInsets.symmetric(
                      vertical: 10,
                      horizontal: 20,
                    ),
                  ),
                  onPressed: () {},
                  child: Text(
                    '$randomNumber min',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
