import 'dart:math';

import 'package:demo/data/api/api_client.dart';
import 'package:demo/screens/course-detail/course_detail.dart';
import 'package:demo/screens/video-detail/video_detail.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class VideoitemComponent extends StatelessWidget {
  final String id;
  final String title;
  final String thumbnail;
  final int views;

  const VideoitemComponent(
      {super.key,
      required this.id,
      required this.title,
      required this.thumbnail,
      required this.views});

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
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Image.network(
                thumbnail.replaceAll('192.168.58.239:8080', '10.0.2.2:8000'),
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
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => VideoDetailScreen(
                          videoId: id,
                        ),
                      ),
                    );
                  },
                  icon: const Icon(
                    Icons.play_circle_fill,
                    color: Colors.white,
                    size: 24,
                  ),
                  label: const Text(
                    'Watch Now',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      letterSpacing: 1.0,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 12),
                    backgroundColor: const Color(
                        0xFF4CAF50), // or use Theme.of(context).primaryColor
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    elevation: 4,
                    shadowColor: Colors.black45,
                  ),
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
