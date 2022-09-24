import 'package:get/get.dart';
import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:url_launcher/url_launcher.dart';
import '../view/word_details.dart';

Future<void> openGlosbe(String fromLang, String toLang, String text) async {
  var url =
      'https://glosbe.com/$fromLang/$toLang/${text.replaceAll(' ', "%20")}';
  if (kIsWeb) {
    await launchUrl(Uri.parse(url));
  } else {
    Get.to(WordDetails(
      url: url,
    ));
  }
}
