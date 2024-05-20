// translation_service.dart
import 'package:translator/translator.dart';

class TranslationService {
  final GoogleTranslator _translator = GoogleTranslator();

  Future<String> translate(String text, String targetLanguage) async {
    var translation = await _translator.translate(text, to: targetLanguage);
    return translation.text;
  }
}
