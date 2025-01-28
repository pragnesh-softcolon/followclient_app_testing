import 'package:get/get.dart';

class Navigation {
  // next page
  Future<void> next(String routeName, {dynamic arguments}) async {
    Get.toNamed(routeName, arguments: arguments);
  }

  // go back
  void goBack() {
    Get.back();
  }

  // go to the next page and remove the previous page
  Future<void> navigateToNextAndRemovePrevious(String routeName,
      {dynamic arguments}) async {
    Get.offNamed(routeName, arguments: arguments);
  }

  // go to the next page and remove all previous pages
  Future<void> navigateToNextAndRemovePreviousAll(String routeName,
      {dynamic arguments}) async {
    Get.offAllNamed(routeName, arguments: arguments);
  }
}
