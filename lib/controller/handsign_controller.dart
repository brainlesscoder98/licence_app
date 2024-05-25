import 'package:get/get.dart';
import '../core/services/firebase_service.dart';

class HandSignController extends GetxController {
  var handSigns = <Map<String, String>>[].obs;
  final FirebaseService _firebaseService = FirebaseService();

  @override
  void onInit() async {
    super.onInit();
   await fetchData(); // Changed from fetchHandSigns to fetchData
  }

  // Renamed fetchHandSigns to fetchData
  Future<void> fetchData() async {
    var data = await _firebaseService.fetchHandSigns();
    handSigns.value = data;
  }
}
