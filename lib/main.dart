import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:licence_app/screens/home_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'GetX Example',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomeScreen(),
    );
  }
}

class MyAppHome extends StatelessWidget {
  final countController = Get.put(CounterController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GetX Example'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GetBuilder<CounterController>(
              builder: (controller) {
                return Text(
                  'Counter: ${controller.count}',
                  style: TextStyle(fontSize: 20),
                );
              },
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () => countController.increment(),
              child: Text('Increment'),
            ),
          ],
        ),
      ),
    );
  }
}

class CounterController extends GetxController {
  var count = 0.obs;

  void increment() {
    count++;
  }
}
