import 'package:demo/auth/login.dart';
import 'package:demo/core/auth.dart';
import 'package:demo/data/models/user_model.dart';
import 'package:demo/data/services/db_service.dart';
import 'package:demo/screens/articles/article.dart';
import 'package:demo/screens/feedback/feedback.dart';
import 'package:demo/screens/instructors/instructor.dart';
import 'package:flutter/material.dart';

Widget buildMenuItem(
    IconData icon, String title, int index, BuildContext context) {
  Future<void> onLogout() async {
    final db = await DB.instance.db;

    // Clear user data from the database
    await db.delete(UserModel.tableName);

    // Optionally reset the in-memory session user
    Auth.instance.onResetAuth();
  }

  return ListTile(
    leading: CircleAvatar(
      backgroundColor: index != 8 ? Colors.blue.shade100 : Colors.red.shade100,
      child: Icon(icon, color: index != 8 ? Colors.blue : Colors.red),
    ),
    title: Text(title),
    trailing: const Icon(Icons.arrow_forward_ios, size: 16),
    onTap: () {
      switch (index) {
        case 0:
          // Navigate to ProfileScreen when profile is clicked
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => FeedbackScreen(),
            ),
          );
          break;
        case 1:
          break;
        case 2:
          // Navigate to ProfileScreen when profile is clicked
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ArticleScreen(),
            ),
          );
          break;
        case 3:
          // Navigate to ProfileScreen when profile is clicked
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => InstructorAgreementPage(),
            ),
          );

          break;
        case 4:
          break;
        case 5:
          break;
        case 6:
          break;
        case 7:
          break;
        case 8:
          onLogout();
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => LoginScreen()),
          );
          break;
      }
    },
  );
}
