import 'package:flutter/material.dart';

class LearnCard extends StatelessWidget {
  const LearnCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(16.0), // Add padding inside the Card
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Row(
              children: [
                CircleAvatar(
                  backgroundImage: AssetImage('assets/images/e-learning.png'),
                  radius: 20,
                ),
                SizedBox(width: 8),
                Text(
                  'Princeton University',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            const Text(
              'Computer Science: Programming with a Purpose',
              style: TextStyle(
                fontSize: 18,
              ),
            ),
            const SizedBox(height: 8),
            LinearProgressIndicator(
              value: 0.01,
              backgroundColor: Colors.grey[300],
              color: Colors.blue,
            ),
            const SizedBox(height: 16),
            const Text(
              'Supplements for Lecture 1',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                ElevatedButton.icon(
                  onPressed: () {
                    // Handle reading button press
                  },
                  icon: const Icon(Icons.article),
                  label: const Text('Reading'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Handle 10 min button press
                  },
                  child: const Text('10 min'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: () {
                    // Handle up next button press
                  },
                  child: const Text('Up Next'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
