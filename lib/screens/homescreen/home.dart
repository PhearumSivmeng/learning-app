import 'package:demo/data/api/api_client.dart';
import 'package:demo/data/models/category_model.dart';
import 'package:demo/data/models/slide_model.dart';
import 'package:demo/data/models/technology_model.dart';
import 'package:demo/screens/articles/article_detail.dart';
import 'package:demo/widget/category_card.dart';
import 'package:demo/widget/certificate_card.dart';
import 'package:demo/widget/course_card.dart';
import 'package:demo/widget/slide_component.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late final http.Client client;
  late final ApiClient apiClient;
  List<SlideModel> _carouselItems = [];
  List<CategoryModel> _categories = [];
  List<AritcleModel> _technologies = [];
  List<AritcleModel> _mostRead = [];

  @override
  void initState() {
    super.initState();
    client = http.Client();
    apiClient = ApiClient(client: client);
    getSlide();
    getCategory();
    getRecommend();
    getMostRead();
  }

  getSlide() async {
    try {
      final response = await apiClient.onGetCarousel(arg: {});
      if (response.status == "success") {
        setState(() {
          _carouselItems = response.records!;
        });
      } else {
        print("Fetch Data Failed: ${response.msg}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  getCategory() async {
    try {
      final response = await apiClient.onGetCategory(arg: {});
      if (response.status == "success") {
        setState(() {
          _categories = response.records!;
        });
      } else {
        print("Fetch Data Failed: ${response.msg}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  getRecommend() async {
    try {
      final response = await apiClient.onGetArticle(arg: {
        "type": "in_home",
      });
      if (response.status == "success") {
        setState(() {
          _technologies = response.records!;
        });
      } else {
        print("Fetch Data Failed: ${response.msg}");
      }
    } catch (e) {
      print("An error occurred: $e");
    }
  }

  getMostRead() async {
    try {
      final response = await apiClient.onGetArticle(arg: {
        "type": "most_read",
      });
      if (response.status == "success") {
        setState(() {
          _mostRead = response.records!;
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
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(10.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 15,
            ),
            CarouselExample(items: _carouselItems),
            const Padding(
              padding: EdgeInsets.only(left: 15, top: 20, right: 15, bottom: 5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Categories',
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _categories.map((category) {
                  return CategoryCard(
                    title: category.name,
                    imageUrl: category.logo,
                  );
                }).toList(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Recommendation',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: _technologies.map((technology) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticleDetailScreen(
                            article: technology,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(
                          right: 10), // spacing between cards
                      child: CertificateCard(
                        title: technology.title,
                        detail: technology.shortDetails,
                        imageUrl: technology.thumbnail
                            .replaceAll('192.168.58.239:8080', '10.0.2.2:8000'),
                      ),
                    ),
                  );
                }).toList(),
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'Most Read',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: _mostRead.map((technology) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ArticleDetailScreen(
                            article: technology,
                          ),
                        ),
                      );
                    },
                    child: Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: CourseCard(
                          title: technology.title,
                          shortDetails: technology.shortDetails,
                          thumbnail: technology.thumbnail),
                    ),
                  );
                }).toList(),
              ),
            )
          ],
        ),
      ),
    );
  }
}
