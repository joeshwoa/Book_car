import 'dart:ui';
import 'package:easy_localization/easy_localization.dart' show AssetLoader;
import 'package:public_app/Core/translations/utils/en.dart';
import 'package:public_app/Core/translations/utils/fr.dart';



class CodegenLoader extends AssetLoader {
  const CodegenLoader();

  @override
  Future<Map<String, dynamic>> load(String path, Locale locale) {
    return Future.value(mapLocales[locale.toString()]);
  }
  static const Map<String, Map<String, dynamic>> mapLocales = {
    "fr": fr,
    "en": en,
  };
}
