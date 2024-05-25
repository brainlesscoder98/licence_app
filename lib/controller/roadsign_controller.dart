import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import '../core/services/firebase_service.dart';

class RoadSignController extends GetxController {
  var roadSigns = <Map<String, String>>[].obs;
  final FirebaseService _firebaseService = FirebaseService();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    var data = await _firebaseService.fetchRoadSigns();
    roadSigns.value = data;
  }
}
