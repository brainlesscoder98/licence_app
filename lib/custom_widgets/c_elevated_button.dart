import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:license_master/app_constants/app_constants.dart';

class CustomElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final double progress;
  final double? width;
  final double? height;

  const CustomElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.progress = 0.0,
    this.width,
    this.height,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width??Get.width,
      height: height??40,
      margin: EdgeInsets.symmetric(horizontal: 20),
      child: InkWell(
        onTap: onPressed,
        child: Container(

          decoration: BoxDecoration(
            color: Colors.green,
            borderRadius: BorderRadius.circular(10),
          ),
          child: Center(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Text(
                  text,
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                if (isLoading)
                  Positioned.fill(
                    child: LinearProgressIndicator(
                      value: progress,
                      backgroundColor: Colors.white,
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.blue),
                    ),
                  ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class LoadingElevatedButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final bool isLoading;
  final double progress;

  const LoadingElevatedButton({
    Key? key,
    required this.text,
    required this.onPressed,
    this.isLoading = false,
    this.progress = 0.0,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: isLoading ? null : onPressed,
      child: Container(
        width: Get.width,
        height: 40,
        decoration: BoxDecoration(
          color: isLoading ? Colors.grey : Colors.green,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Stack(
          alignment: Alignment.center,
          children: [

            if (isLoading)
              Positioned.fill(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: LinearProgressIndicator(
                    value: progress,
                    backgroundColor: Colors.transparent,
                    valueColor: AlwaysStoppedAnimation<Color>(Colors.green),
                  ),
                ),
              ),
            Text(
              isLoading ? 'Upload Progress:${(progress * 100).toStringAsFixed(2)}%' : text,
              style: TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }
}
