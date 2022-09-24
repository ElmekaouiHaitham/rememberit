import 'package:flutter/cupertino.dart';

class AppColors {
  static final Color mainColor =
      WidgetsBinding.instance.window.platformBrightness == Brightness.dark
          ? const Color(0xFF303030)
          : const Color(0xFFFFFFFF);
  static final Color iconColor =
      WidgetsBinding.instance.window.platformBrightness == Brightness.dark
          ? const Color(0xFFFFFFFF)
          : const Color(0xFF303030);
  static const Color translateFromColor = Color(0xFF4285F4);
  static const Color progressBarColor = Color.fromARGB(255, 120, 68, 184);
}
