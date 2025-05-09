import 'package:demo/core/util/my_theme.dart';
import 'package:demo/data/api/api_client.dart';
import 'package:demo/data/models/technology_model.dart';
import 'package:demo/data/models/video_model.dart';
import 'package:demo/screens/articles/article_detail.dart';
import 'package:demo/widget/course_card.dart';
import 'package:demo/widget/learnItem_component.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class ArticleScreen extends StatefulWidget {
  const ArticleScreen({super.key});

  @override
  State<ArticleScreen> createState() => _ArticleScreenState();
}

class _ArticleScreenState extends State<ArticleScreen> {
  late final http.Client client;
  late final ApiClient apiClient;
  List<AritcleModel> _article = [];
  int page = 1;

  @override
  void initState() {
    super.initState();
    client = http.Client();
    apiClient = ApiClient(client: client);
    getCourses(page);
  }

  getCourses(page) async {
    try {
      final response = await apiClient.onGetArticle(arg: {
        "limit": page * 10,
      });
      if (response.status == "success") {
        setState(() {
          _article = response.records!;
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
    return Scaffold(
        appBar: AppBar(
          shadowColor: const Color.fromARGB(255, 195, 50, 50),
          toolbarHeight: 70,
          backgroundColor: Colors.white,
          leading: IconButton(
            icon: const Icon(Icons.arrow_back, color: Colors.black),
            onPressed: () => Navigator.pop(context),
          ),
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                '[ Articles ]',
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: 10), // Add some space between text and logo
            ],
          ),
          actions: [SizedBox(width: 40)], // This balances the leading arrow
        ),
        backgroundColor: MyTheme.bodyBackground,
        body: Container(
          child: Container(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(10.0),
              child: Column(
                children: _article.map((item) {
                  return Padding(
                    padding: const EdgeInsets.only(bottom: 10),
                    child: GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ArticleDetailScreen(
                              article: item,
                            ),
                          ),
                        );
                      },
                      child: CourseCard(
                          title: item.title,
                          shortDetails: item.shortDetails,
                          thumbnail: item.thumbnail),
                    ),
                  );
                }).toList(),
              ),
            ),
          ),
        ));
  }
}
