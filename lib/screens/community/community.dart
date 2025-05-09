import 'package:demo/data/api/api_client.dart';
import 'package:demo/data/models/question_model.dart';
import 'package:demo/widget/questionItem_component.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CommunityScreen extends StatefulWidget {
  const CommunityScreen({super.key});

  @override
  State<CommunityScreen> createState() => _CommunityScreenState();
}

class _CommunityScreenState extends State<CommunityScreen> {
  List<bool> isSelected = [false, true];
  late final http.Client client;
  late final ApiClient apiClient;
  List<QuestionModel> _questions = [];
  
  @override
  void initState() {
    super.initState();
    client = http.Client();
    apiClient = ApiClient(client: client);
    getAllQuestions();
  }

  getAllQuestions() async {
    try {
      final response = await apiClient.onGetQuestions(arg: {});
      if (response.status == "success") {
        setState(() {
          _questions = response.records!;
          _questions.sort((a, b) => b.answer.compareTo(a.answer));
        });
      } else {
        print("Fetch Data Failed: ${response.msg}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Expanded(
            child: ListView.builder(
              itemCount: _questions.length, // Example count
              itemBuilder: (context, index) {
                return QuestionCard(
                  answer: _questions[index].answer,
                  title: _questions[index].title,
                  description: _questions[index].description,
                  user: _questions[index].user,
                  profile: _questions[index].profile,
                  tags: _questions[index].tags,
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
