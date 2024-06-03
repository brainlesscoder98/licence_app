import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:license_master/controller/banner_controller.dart';

class MainBanner extends StatelessWidget {
  final BannerController bannerController = Get.put(BannerController());
  
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(20),
          child: CarouselSlider(
            options: CarouselOptions(
              height: 150.0,
              autoPlay: true,
              enlargeCenterPage: true,
              // aspectRatio: 16/9,
              autoPlayInterval: Duration(seconds: 3),
              autoPlayAnimationDuration: Duration(milliseconds: 800),
              autoPlayCurve: Curves.fastOutSlowIn,
              enableInfiniteScroll: true,
              viewportFraction: 1,
            ),
            items: bannerController.mainBanner.map((url) {
              return Builder(
                builder: (BuildContext context) {
          
                  return Container(
                    width: MediaQuery.of(context).size.width,
                    margin: EdgeInsets.symmetric(horizontal: 5.0),
                    decoration: BoxDecoration(
                      color: Colors.grey,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: CachedNetworkImage(
                        imageUrl:url['imageUrl'].toString(),
                        placeholder: (context, url) => Image.network(
                          'https://firebasestorage.googleapis.com/v0/b/kerala-psc-papers.appspot.com/o/banners%2Fpexels-kelly-1179532-2876511.jpg?alt=media&token=eabcabf2-f01f-4db9-949d-dbc5c00045f3', // Replace with your placeholder image path
                          fit: BoxFit.cover,
                        ),
                        errorWidget: (context, url, error) => Icon(Icons.error),
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
              );
            }).toList(),
          ),
        ),
      ),
    );
  }
}