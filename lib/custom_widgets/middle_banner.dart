import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

class MiddleBanner extends StatelessWidget {
  final List<String> imageUrls = [
    'https://via.placeholder.com/600x400',
    'https://via.placeholder.com/600x400',
    'https://via.placeholder.com/600x400',
    'https://via.placeholder.com/600x400',
    'https://via.placeholder.com/600x400',
  ];

  @override
  Widget build(BuildContext context) {
    return Center(
      child: CarouselSlider(
        options: CarouselOptions(
          height: 100.0,
          autoPlay: true,
          enlargeCenterPage: true,
          // aspectRatio: 16/9,
          autoPlayInterval: Duration(seconds: 3),
          autoPlayAnimationDuration: Duration(milliseconds: 800),
          autoPlayCurve: Curves.fastOutSlowIn,
          enableInfiniteScroll: true,
          viewportFraction: 0.8,
        ),
        items: imageUrls.map((url) {
          return Builder(
            builder: (BuildContext context) {
              return Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(
                  color: Colors.amber,
                ),
                child: CachedNetworkImage(
                  imageUrl: url,
                  placeholder: (context, url) => Image.asset(
                    'assets/images/sign_board.jpg', // Replace with your placeholder image path
                    fit: BoxFit.cover,
                  ),
                  errorWidget: (context, url, error) => Icon(Icons.error),
                  fit: BoxFit.fill,
                ),
              );
            },
          );
        }).toList(),
      ),
    );
  }
}