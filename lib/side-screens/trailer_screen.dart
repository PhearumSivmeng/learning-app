import 'package:flutter/material.dart';

class CourseDetailScreen extends StatelessWidget {
  const CourseDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Custom AppBar Title
        title: const Text(
          'Course Detail',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue.shade500,
        // Custom leading icon for the back button
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back, // Back arrow icon
            color: Colors.white, // Set the icon color to white
          ),
          onPressed: () {
            Navigator.of(context).pop();
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Learn to Program: The Fundamentals',
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(Icons.star, color: Colors.yellow),
                  Text('4.7 (6.4k)', style: TextStyle(fontSize: 16)),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(Icons.language),
                  SizedBox(width: 5),
                  Text('Taught in English'),
                  Spacer(),
                  Text('21 languages available',
                      style: TextStyle(decoration: TextDecoration.underline)),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                children: [
                  const Text('Offered By',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                  const Spacer(),
                  Image.network(
                    '',
                    width: 10,
                  ),
                  const SizedBox(width: 5),
                  const Text('University of Toronto',
                      style: TextStyle(fontWeight: FontWeight.bold)),
                ],
              ),
              const SizedBox(height: 20),
              const Text(
                'About this Course',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Behind every mouse click and touch-screen tap, there is a computer program that makes things happen. This course introduces the fundamental building blocks of programming and teaches you how to write fun and useful programs...',
              ),
              const SizedBox(height: 20),
              const Row(
                children: [
                  Icon(Icons.online_prediction),
                  SizedBox(width: 5),
                  Text('100% online'),
                  Spacer(),
                  Text('Start instantly and learn at your own schedule'),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(Icons.schedule),
                  SizedBox(width: 5),
                  Text('Flexible deadlines'),
                  Spacer(),
                  Text('Reset deadline in accordance to your schedule'),
                ],
              ),
              const SizedBox(height: 10),
              const Row(
                children: [
                  Icon(Icons.bar_chart),
                  SizedBox(width: 5),
                  Text('Beginner Level'),
                ],
              ),
              const SizedBox(height: 20),
              Center(
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade500, // Background color
                  ),
                  child: const Text(
                    'See enrollment options',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
              ),
              const SizedBox(height: 10),
              const Center(
                child: Text('Starts Aug 6'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
