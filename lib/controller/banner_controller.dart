import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import '../core/services/firebase_service.dart';

class BannerController extends GetxController {
  var mainBanner = <Map<String, String>>[].obs;
  var subBanner = <Map<String, String>>[].obs;
  final FirebaseService _firebaseService = FirebaseService();

  @override
  void onInit()  {
    super.onInit();
     fetchMainBanner();
     fetchSubBanner();
  }

  Future<void> fetchMainBanner() async {
    var data = await _firebaseService.fetchMainBanner();
    mainBanner.value = data;
  }

  Future<void>  fetchSubBanner() async {
    var data = await _firebaseService.fetchSubBanner();
    subBanner.value = data;
  }
}
