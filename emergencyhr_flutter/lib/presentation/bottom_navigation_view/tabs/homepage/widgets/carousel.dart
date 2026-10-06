import 'package:emergencyhr_flutter/core/cores.dart';
import 'package:flutter/material.dart';

import 'package:carousel_slider/carousel_slider.dart';

class CarouselWidget extends StatelessWidget {
  final Function(int, CarouselPageChangedReason) onPageChanged;
  final List<String> quotes;
  const CarouselWidget({
    super.key,
    required this.onPageChanged,
    required this.quotes,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: CarouselSlider(
        options: CarouselOptions(
          autoPlay: true,
          enlargeCenterPage: true,
          autoPlayInterval: const Duration(seconds: 3),
          autoPlayAnimationDuration: const Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          pauseAutoPlayOnTouch: true,
          enableInfiniteScroll: true,
          viewportFraction: 1,
          onPageChanged: onPageChanged,
        ),
        items: quotes.map((String image) {
          return AppRectangle(
            radius: 10,
            child: Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(10),
                child: Image.asset(
                  image,
                  fit: BoxFit.cover,
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
