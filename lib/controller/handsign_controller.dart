import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import '../core/services/firebase_service.dart';

class HandSignController extends GetxController {
  var handSigns = <Map<String, String>>[].obs;
  final FirebaseService _firebaseService = FirebaseService();

  @override
  void onInit() {
    super.onInit();
    fetchHandSigns();
  }

  void fetchHandSigns() async {
    var data = await _firebaseService.fetchHandSigns();
    handSigns.value = data;
  }
}
