import 'package:demo/widget/category_card.dart';
import 'package:demo/widget/certificate_card.dart';
import 'package:demo/widget/course_card.dart';
import 'package:demo/widget/slide_component.dart';
import 'package:flutter/material.dart';
class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

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
            CarouselExample(),
            const Padding(
              padding: EdgeInsets.only(
                  left: 15, top: 20, right: 15, bottom: 5),
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
                  children: [
                    CategoryCard(
                      title: 'Vue.js',
                      imageUrl:
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Vue.js_Logo_2.svg/1200px-Vue.js_Logo_2.svg.png',
                    ),
                    CategoryCard(
                      title: 'React.js',
                      imageUrl:
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/React-icon.svg/1200px-React-icon.svg.png',
                    ),
                    CategoryCard(
                      title: 'Vue.js',
                      imageUrl:
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Vue.js_Logo_2.svg/1200px-Vue.js_Logo_2.svg.png',
                    ),
                    CategoryCard(
                      title: 'React.js',
                      imageUrl:
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/React-icon.svg/1200px-React-icon.svg.png',
                    ),
                    CategoryCard(
                      title: 'Vue.js',
                      imageUrl:
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/9/95/Vue.js_Logo_2.svg/1200px-Vue.js_Logo_2.svg.png',
                    ),
                    CategoryCard(
                      title: 'React.js',
                      imageUrl:
                          'https://upload.wikimedia.org/wikipedia/commons/thumb/a/a7/React-icon.svg/1200px-React-icon.svg.png',
                    ),
                  ],
                )),
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
                children: [
                  CertificateCard(
                    title: 'Certificate 1',
                    detail:
                        'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock,',
                    imageUrl:
                        'assets/images/e-learning.png', // Ensure this is correct
                  ),
                  const SizedBox(width: 5),
                  CertificateCard(
                    title: 'Certificate 2',
                    detail:
                        'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock,',
                    imageUrl:
                        'assets/images/e-learning.png', // Ensure this is correct
                  ),
                  const SizedBox(width: 5),
                  CertificateCard(
                    title: 'Certificate 2',
                    detail:
                        'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock,',
                    imageUrl:
                        'assets/images/e-learning.png', // Ensure this is correct
                  ),
                  const SizedBox(width: 5),
                  CertificateCard(
                    title: 'Certificate 2',
                    detail:
                        'Contrary to popular belief, Lorem Ipsum is not simply random text. It has roots in a piece of classical Latin literature from 45 BC, making it over 2000 years old. Richard McClintock,',
                    imageUrl:
                        'assets/images/e-learning.png', // Ensure this is correct
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.all(15.0),
              child: Text(
                'New Release',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
            ),
            SingleChildScrollView(
              child: Column(
                children: [
                  CourseCard(),
                  CourseCard(),
                  CourseCard(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
