import 'package:demo/data/api/api_client.dart';
import 'package:demo/data/models/user_model.dart';
import 'package:demo/data/services/db_service.dart';
import 'package:flutter/material.dart';
import 'package:demo/core/util/my_theme.dart';
import 'package:http/http.dart' as http;

class FeedbackScreen extends StatefulWidget {
  const FeedbackScreen({super.key});

  @override
  State<FeedbackScreen> createState() => _FeedbackScreenState();
}

class _FeedbackScreenState extends State<FeedbackScreen> {
  final TextEditingController _feedbackController = TextEditingController();
  late final http.Client client;
  late final ApiClient apiClient;

  @override
  void initState() {
    super.initState();
    client = http.Client();
    apiClient = ApiClient(client: client);
  }

  void submitFeedback() async {
    final db = await DB.instance.db;
    final result = await db.query(UserModel.tableName);
    final token = result[0]["token"];
    final feedback = _feedbackController.text.trim();
    if (feedback.isNotEmpty) {
      final response = await apiClient
          .onGetArticle(arg: {"token": token, "description": feedback});
      if (response.status == "success") {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Thank you for your feedback!")),
        );
        _feedbackController.clear();
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Fail to Feedback!")),
        );
      }
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Please Input your feedback!")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: MyTheme.bodyBackground,
      appBar: AppBar(
        shadowColor: const Color.fromARGB(255, 195, 50, 50),
        toolbarHeight: 70,
        backgroundColor: Colors.white,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, color: Colors.black),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              '[ Feedback ]',
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        actions: const [SizedBox(width: 40)],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            const Text(
              'We will value your feedback',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const Text(
              'Please freedomly express your comment',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 20),
            TextField(
              controller: _feedbackController,
              maxLines: 8,
              decoration: InputDecoration(
                hintText: 'Type your feedback here...',
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: submitFeedback,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blue,
                padding:
                    const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
              child: const Text(
                'Submit',
                style: TextStyle(
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
