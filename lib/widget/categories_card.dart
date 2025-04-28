import 'package:flutter/material.dart';

class AnalysisCard extends StatelessWidget {
  const AnalysisCard({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Circular Image
          Container(
            width: 50, // Adjust size of the circle
            height: 50,
            decoration: const BoxDecoration(
              shape: BoxShape.circle,
              image: DecorationImage(
                fit: BoxFit.cover,
                image: NetworkImage(
                  'https://via.placeholder.com/150', // Replace with your image URL
                ),
              ),
            ),
          ),
          const SizedBox(width: 12), // Spacing between image and text

          // Title and Description
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title
                Text(
                  'Analysis',
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),
                ),
                SizedBox(
                    height: 4), // Small spacing between title and description

                // Description
                Text(
                  'Analysis is the process of breaking down complex information or syste...',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey,
                  ),
                  overflow: TextOverflow.ellipsis,
                  maxLines: 2, // Restrict to 2 lines
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
