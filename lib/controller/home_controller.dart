import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import '../core/services/firebase_service.dart';

class HomeController extends GetxController {
  var languages = <Map<String, String>>[].obs;

  final FirebaseService _firebaseService = FirebaseService();

  @override
  void onInit()  {
    super.onInit();
    fetchLanguages();
  }

  Future<void> fetchLanguages() async {
    var data = await _firebaseService.fetchLanguages();
    languages.value = data;
  }
}
