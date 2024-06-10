import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import '../core/services/firebase_service.dart';

class AboutusController extends GetxController {
  var notes = <Map<String, String>>[].obs;
  final FirebaseService _firebaseService = FirebaseService();

  @override
  void onInit() {
    super.onInit();
    fetchData();
  }

  Future<void> fetchData() async {
    var data = await _firebaseService.fetchAboutUs();
    notes.value = data;
  }
}
