import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:license_master/controller/banner_controller.dart';
import '../app_constants/app_constants.dart';
import '../core/services/firebase_service.dart';
import '../main.dart';

class HomeController extends GetxController {
  var languages = <Map<String, String>>[].obs;
  var homeItems = <Map<String, String>>[].obs;
  var drawerItems = <Map<String, String>>[].obs;

  final FirebaseService _firebaseService = FirebaseService();
  final BannerController bannerController = Get.put(BannerController());

  @override
  void onInit() async {
    super.onInit();
    await fetchHomeItems();
    await fetchLanguages();
    await fetchSideDrawerItems();
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
  Future<void> fetchSideDrawerItems() async {
    var data = await _firebaseService.fetchSideDrawer();
    drawerItems.value = data;
  }
  String getItemIndex(Map<String, dynamic> itemIndexs){
    String itemIndex = itemIndexs['index']?.toString() ?? "0";
    return itemIndex;
  }
  String isDrawerItemVisible(Map<String, dynamic> drawerItem) {
    String visibility = drawerItem['visibility'].toString()??'';
    return visibility;
  }
  String getRedirectionLink(Map<String, dynamic> redirectionLink){
    String link = redirectionLink['redirection_link']?.toString() ?? '';
    return link;
  }
  String getLocalizedTitle(Map<String, dynamic> drawerItems) {
    String title = drawerItems['title']?.toString() ?? 'No Title';
    switch (appStorage.read(AppConstants().appLang.toString())) {
      case 'ml':
        return drawerItems['title_ml']?.toString() ?? title;
      case 'hi':
        return drawerItems['title_hi']?.toString() ?? title;
      case 'ta':
        return drawerItems['title_ta']?.toString() ?? title;
      default:
        return title;
    }
  }
}
