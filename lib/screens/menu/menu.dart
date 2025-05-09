import 'package:demo/data/models/user_model.dart';
import 'package:demo/screens/profile/profile.dart';
import 'package:demo/widget/build_menu_item.dart';
import 'package:flutter/material.dart';

import '../../../data/services/db_service.dart';

class MenuScreen extends StatelessWidget {
  const MenuScreen({super.key});

  Future<UserModel?> _getUserData() async {
    final db = await DB.instance.db;
    final result = await db.query(UserModel.tableName);

    if (result.isNotEmpty) {
      return UserModel.fromJson(
          result.first); // Assuming you have fromJson method in your UserModel
    } else {
      return null;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<UserModel?>(
        future: _getUserData(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
                child:
                    CircularProgressIndicator()); // Show loading indicator while waiting for data
          }

          if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          }

          final user = snapshot.data;
          if (user == null) {
            return const Center(child: Text('No user data found.'));
          }

          return Column(
            children: [
              Material(
                color: Colors.blue,
                child: InkWell(
                  onTap: () {
                    // Navigate to ProfileScreen when profile is clicked
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProfilePage(user: user),
                      ),
                    );
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        CircleAvatar(
                          radius: 30,
                          backgroundColor: Colors.white,
                          backgroundImage: NetworkImage(
                            user.profile.replaceAll(
                                "192.168.70.70:8080", "10.0.2.2:8000"),
                          ),
                        ),
                        const SizedBox(width: 16),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              '${user.firstName} ${user.lastName}',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            Text(
                              user.email,
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                            Text(
                              'Tel: ${user.phone}',
                              style: const TextStyle(
                                color: Colors.white70,
                                fontSize: 14,
                              ),
                            ),
                          ],
                        ),
                        const Spacer(),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 15,
              ),
              Expanded(
                child: ListView(
                  children: [
                    buildMenuItem(Icons.feedback, 'Feedback', 0, context),
                    buildMenuItem(Icons.video_collection_rounded, 'Short Video',
                        1, context),
                    buildMenuItem(Icons.article, 'Article', 2, context),
                    buildMenuItem(
                        Icons.assignment_ind_sharp, 'Instructor', 3, context),
                    buildMenuItem(Icons.assignment, 'Assignment', 4, context),
                    buildMenuItem(Icons.info, 'About Us', 5, context),
                    buildMenuItem(
                        Icons.contact_support, 'Contact Us', 6, context),
                    buildMenuItem(Icons.help, 'FAQ', 7, context),
                    buildMenuItem(Icons.logout, 'Logout', 8, context),
                  ],
                ),
              ),
            ],
          );
        });
  }
}
