import 'package:demo/data/api/api_client.dart';
import 'package:demo/data/models/video_model.dart';
import 'package:demo/widget/learnItem_component.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  late final http.Client client;
  late final ApiClient apiClient;
  List<VideoModel> _videos = [];
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
      final response = await apiClient.onGetCourseVideo(arg: {
        "limit": page * 10,
      });
      if (response.status == "success") {
        setState(() {
          _videos = response.records!;
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
    return Container(
      child: Container(
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(10.0),
          child: Column(
            children: _videos.map((item) {
              return LearnCard(
                title: item.title,
                thumbnail: item.thumbnail,
                views: item.views,
                profileInstructor: item.profileInstructor,
                instructor: item.instructor,
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}
