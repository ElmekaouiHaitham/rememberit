import "package:get/get.dart";

class Dimensions {
  static double getDHsize(double size) {
    double screenWidth2 = Get.context!.width;
    double hDFactor2 = screenWidth2 / 500;
    return size * hDFactor2;
  }

  static double getDVsize(double size) {
    double screenHeight2 = Get.context!.height;
    double vDFactor2 = screenHeight2 / 647;
    return size * vDFactor2;
  }
}
