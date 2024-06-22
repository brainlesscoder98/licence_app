import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

String appLang = "en";
class AppConstants{
  final Size mediaSize = Get.size;
  final String appLang = "en";
  final String isLoggedIn = "0";
}
final appPrimaryColor = Color(0xff171D22);
class GlobalDecoration {
  static  BoxDecoration containerDecoration = BoxDecoration(
    gradient: LinearGradient(
      colors: [
        // Colors.teal,
        Color.fromRGBO(16, 2, 51, 1),
        Color.fromARGB(255, 0, 0, 0), // Black
      ],
      begin: Alignment.centerLeft,
      end: Alignment.centerRight,
    ),
  );
}
