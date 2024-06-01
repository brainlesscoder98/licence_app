import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:licence_app/controller/banner_controller.dart';
import '../core/services/firebase_service.dart';

class HomeController extends GetxController {
  var languages = <Map<String, String>>[].obs;
  var homeItems = <Map<String, String>>[].obs;

  final FirebaseService _firebaseService = FirebaseService();
  final BannerController bannerController = Get.put(BannerController());

  @override
  void onInit()  {
    super.onInit();
    fetchHomeItems();
    fetchLanguages();
    bannerController.fetchMainBanner();
  }

  Future<void> fetchHomeItems() async {
    var data = await _firebaseService.fetchHomeItems();
    homeItems.value = data;
  }
  Future<void> fetchLanguages() async {
    var data = await _firebaseService.fetchLanguages();
    languages.value = data;
  }
}
