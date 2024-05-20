import 'package:get/get.dart';
import '../core/services/firebase_service.dart';

class SignboardController extends GetxController {
  var signboards = <Map<String, String>>[].obs;
  final FirebaseService _firebaseService = FirebaseService();

  @override
  void onInit() {
    super.onInit();
    fetchSignboards();
  }

  void fetchSignboards() async {
    var data = await _firebaseService.fetchSignboards();
    signboards.value = data;
  }
}
