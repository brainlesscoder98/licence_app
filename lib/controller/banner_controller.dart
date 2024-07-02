import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import '../core/services/firebase_service.dart';

class BannerController extends GetxController {
  var mainBanner = <Map<String, String>>[].obs;
  var subBanner = <Map<String, String>>[].obs;
  final FirebaseService _firebaseService = FirebaseService();
  RxBool isLoading = false.obs;
  @override
  void onInit()  {
    super.onInit();
     fetchMainBanner();

  }

  Future<void> fetchMainBanner() async {
    isLoading.value = true;
    var data = await _firebaseService.fetchMainBanner();
    mainBanner.value = data;
    isLoading.value = false;
  }

  // Future<void>  fetchSubBanner() async {
  //   var data = await _firebaseService.fetchSubBanner();
  //   subBanner.value = data;
  // }
}
