import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselExample extends StatelessWidget {
  final List<String> images = [
    'https://www.simplilearn.com/ice9/free_resources_article_thumb/What_is_Data_Analysis.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRNPJJqYm740HTSHZu-hNUdF8Gp1Ih1JswphQ&s',
    'https://psomba.com/wp-content/uploads/2024/08/business-analytist.jpg',
    'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRAU3e5xiEUmtCmtK48BMmOPEI1rzKgg7uDqQ&s'
  ];

  CarouselExample({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CarouselSlider(
        options: CarouselOptions(
          height: 230.0,
          enlargeCenterPage: true,
          aspectRatio: 16 / 9,
          autoPlayInterval: const Duration(seconds: 5),
          autoPlayAnimationDuration: const Duration(milliseconds: 1000),
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          viewportFraction: 0.8,
        ),
        items: images.map((imageUrl) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.amber,
                ),
                child: Image.network(
                  imageUrl,
                  fit: BoxFit.cover,
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}
