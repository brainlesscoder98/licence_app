// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:carousel_slider/carousel_slider.dart';
// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
//
// import '../controller/banner_controller.dart';
//
// class MiddleBanner extends StatelessWidget {
//   final BannerController bannerController = Get.put(BannerController());
//
//   @override
//   Widget build(BuildContext context) {
//     return Center(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(horizontal: 20),
//         child: CarouselSlider(
//           options: CarouselOptions(
//             height: 150.0,
//             autoPlay: true,
//             enlargeCenterPage: true,
//             // aspectRatio: 16/9,
//             autoPlayInterval: Duration(seconds: 5),
//             autoPlayAnimationDuration: Duration(milliseconds: 800),
//             autoPlayCurve: Curves.fastOutSlowIn,
//             enableInfiniteScroll: true,
//             viewportFraction:1,
//           ),
//           items: bannerController.subBanner.map((url) {
//             return Builder(
//               builder: (BuildContext context) {
//                 return Container(
//                   width: MediaQuery.of(context).size.width,
//                   margin: EdgeInsets.symmetric(horizontal: 5.0),
//                   decoration: BoxDecoration(
//                     color: Colors.black,
//                     borderRadius: BorderRadius.circular(20),
//                   ),
//                   child: ClipRRect(
//                     borderRadius: BorderRadius.circular(20),
//                     child: CachedNetworkImage(
//                       imageUrl: url['imageUrl'].toString(),
//                       placeholder: (context, url) => Image.asset(
//                         'assets/images/2.jpg', // Replace with your placeholder image path
//                         fit: BoxFit.cover,
//                       ),
//                       errorWidget: (context, url, error) => Icon(Icons.error),
//                       fit: BoxFit.fill,
//                     ),
//                   ),
//                 );
//               },
//             );
//           }).toList(),
//         ),
//       ),
//     );
//   }
// }