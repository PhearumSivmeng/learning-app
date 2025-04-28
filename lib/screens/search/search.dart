import 'package:flutter/material.dart';

class SearchPage extends StatelessWidget {
  const SearchPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // Custom AppBar Title
        title: const Text(
          'Search',
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
        backgroundColor: Colors.blue.shade500,
        // Custom leading icon for the back button
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Search bar
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: TextField(
                style: const TextStyle(
                  color: Colors.white, // Set the text color to white
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                ),
                decoration: InputDecoration(
                  hintStyle: const TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 16),
                  hintText: 'What you want to learn?',
                  prefixIcon: const Icon(
                    Icons.search,
                    color: Colors.white,
                  ),
                  filled: true,
                  fillColor: Colors.blue.shade500,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: BorderSide.none,
                  ),
                ),
              ),
            ),
            const SizedBox(height: 16),

            // Recently Viewed
            const Text(
              'Recently Viewed',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildRecentlyViewedItem(
              'assets/images/e-learning.png', // Replace with your image asset
              'Google Data Analytics',
              'Google',
            ),
            _buildRecentlyViewedItem(
              'assets/images/google-cloud.png', // Replace with your image asset
              'Google Cloud Data Analytics',
              'Google Cloud',
            ),
            TextButton(
              onPressed: () {
                // Handle clear button press
              },
              child: const Text(
                'Clear',
                style: TextStyle(color: Colors.blue),
              ),
            ),

            // Recent Searches
            const Text(
              'Recent Searches',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildRecentSearchItem('data analyst'),
            _buildRecentSearchItem('Engineering drawing'),
            TextButton(
              onPressed: () {
                // Handle clear button press
              },
              child: const Text(
                'Clear',
                style: TextStyle(color: Colors.blue),
              ),
            ),

            // Popular Searches
            const Text(
              'Popular Searches',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            _buildPopularSearchItem('machine learning'),
            _buildPopularSearchItem('ai'),
          ],
        ),
      ),
      bottomNavigationBar: BottomNavigationBar(
        // Set the background color of the BottomNavigationBar
        backgroundColor: Colors.blue.shade500,
        // Define the items in the BottomNavigationBar
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.explore),
            label: 'Explore',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.people),
            label: 'Community',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.book),
            label: 'Learn',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Search',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
        currentIndex: 3, // Set the initial selected item
        selectedItemColor: Colors.white, // Set the color for the selected item
        unselectedItemColor: Colors.white.withOpacity(
            0.7), // Set color for unselected items with some transparency for visual effect
        onTap: (index) {
          // Handle item tap here
          print("Tapped on index: $index");
        },
        type: BottomNavigationBarType
            .fixed, // Ensure the items stay fixed and don't move
      ),
    );
  }

  Widget _buildRecentlyViewedItem(
      String imagePath, String title, String subtitle) {
    return ListTile(
      leading: CircleAvatar(
        backgroundImage: AssetImage(imagePath),
      ),
      title: Text(title),
      subtitle: Text(subtitle),
    );
  }

  Widget _buildRecentSearchItem(String searchQuery) {
    return ListTile(
      leading: const Icon(Icons.history),
      title: Text(searchQuery),
    );
  }

  Widget _buildPopularSearchItem(String searchQuery) {
    return ListTile(
      leading: const Icon(Icons.trending_up),
      title: Text(searchQuery),
    );
  }
}
