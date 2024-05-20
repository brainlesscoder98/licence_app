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

  Future<void> translateDynamicTexts(List<Map<String, String>> items, String targetLanguage) async {
    for (var item in items) {
      var translatedName = await _translationService.translate(item['name']!, targetLanguage);
      var translatedDescription = await _translationService.translate(item['description']!, targetLanguage);
      translatedTexts[item['name']!] = translatedName;
      translatedTexts[item['description']!] = translatedDescription;
    }
  }

  String getTranslated(String key) {
    return translatedTexts[key] ?? key;
  }
}
