import 'package:get/get.dart';
import 'package:remenberit/controllers/main_controller.dart';
import 'package:remenberit/repositories/auth_repo.dart';

import 'controllers/auth_controller.dart';
import 'repositories/main_repo.dart';

Future<void> init() async {
  // repositories
  Get.lazyPut(() => MainRepo());
  Get.lazyPut(() => AuthRepo());
  // controllers
  Get.lazyPut(() => MainController(Get.find()));
  Get.lazyPut(() => AuthController(Get.find()));
}
