import 'package:demo/core/util/my_theme.dart';
import 'package:demo/data/api/api_client.dart';
import 'package:demo/data/models/video_model.dart';
import 'package:demo/widget/videoItem_component.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CourseDetailScreen extends StatefulWidget {
  final String tech;
  final String instructorId;

  const CourseDetailScreen({
    super.key,
    required this.tech,
    required this.instructorId,
  });

  @override
  State<CourseDetailScreen> createState() => _CourseDetailScreenState();
}

class _CourseDetailScreenState extends State<CourseDetailScreen> {
  late final http.Client client;
  late final ApiClient apiClient;
  List<VideoModel> _videos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    client = http.Client();
    apiClient = ApiClient(client: client);
    getCourses();
  }

  @override
  void dispose() {
    client.close(); // Close the HTTP client when the widget is disposed
    super.dispose();
  }

  Future<void> getCourses() async {
    if (widget.tech.isEmpty || widget.instructorId.isEmpty) {
      print("Error: tech or instructorId is empty");
      return;
    }

    try {
      final response = await apiClient.onGetCourseVideo(arg: {
        "tech": widget.tech,
        "instructor": widget.instructorId,
      });
      print("API Response: ${response}");

      if (mounted) {
        setState(() {
          _videos = response.records ?? [];
          _isLoading = false;
        });
      }
    } catch (e) {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
      print("An error occurred: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white,
        title: _isLoading || _videos.isEmpty
            ? Text('Course Details')
            : Row(
                children: [
                  CircleAvatar(
                    backgroundImage: NetworkImage(_videos[0]
                        .profileInstructor
                        .replaceAll('192.168.58.239:8080', '10.0.2.2:8000')),
                    radius: 18,
                  ),
                  SizedBox(width: 10),
                  Text(
                    _videos[0].instructor,
                    style: TextStyle(color: Colors.black),
                  ),
                  SizedBox(width: 10),
                  Text(
                    '[ Flutter ]',
                    style: TextStyle(
                      color: Colors.blueAccent,
                    ),
                  ),
                ],
              ),
      ),
      backgroundColor: MyTheme.bodyBackground,
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _videos.isEmpty
              ? Center(child: Text('No videos available'))
              : SingleChildScrollView(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    children: _videos.map((item) {
                      return VideoitemComponent(
                        id: item.id,
                        title: item.title,
                        thumbnail: item.thumbnail,
                        views: item.views,
                      );
                    }).toList(),
                  ),
                ),
    );
  }
}
