import 'package:get/get.dart';

class BaseController extends GetxController{
  int currentIndex = 0;

  /// change the selected screen index
  changeScreen(int selectedIndex) {
    currentIndex = selectedIndex;
    update();
  }
}