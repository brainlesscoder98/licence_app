// translation_controller.dart
import 'package:get/get.dart';
import 'package:licence_app/controller/translator_service.dart';

class TranslationController extends GetxController {
  final TranslationService _translationService = TranslationService();
  var translatedTexts = <String, String>{}.obs;

  Future<void> translateTexts(Map<String, String> texts, String targetLanguage) async {
    for (var key in texts.keys) {
      var translation = await _translationService.translate(texts[key]!, targetLanguage);
      translatedTexts[key] = translation;
    }
  }


  String getTranslated(String key) {
    return translatedTexts[key] ?? key;
  }
}
