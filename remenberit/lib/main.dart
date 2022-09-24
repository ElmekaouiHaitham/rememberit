import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remenberit/view/auth_page.dart';
import 'package:remenberit/view/home_page.dart';

import 'controllers/auth_controller.dart';
import 'dependencies.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'rememberIt',
      theme: ThemeData(
        brightness: WidgetsBinding.instance.window.platformBrightness,
      ),
      home: Get.find<AuthController>().isLoggedIn() ? const HomePage() : const AuthPage(),
    );
  }
}
