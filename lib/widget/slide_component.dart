import 'package:demo/data/models/slide_model.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class CarouselExample extends StatelessWidget {
  final List<SlideModel> items;

  const CarouselExample({super.key, required this.items});

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
        items: items.map((item) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                  color: Colors.amber,
                ),
                child: Image.network(
                  item.thumbnail
                      .replaceAll('192.168.58.239:8080', '10.0.2.2:8000'),
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
