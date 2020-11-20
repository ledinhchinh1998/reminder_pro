import 'package:flutter/animation.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:note_app_pro/app/modules/home/home_view.dart';
import 'package:note_app_pro/app/utils/color_extension.dart';


class SplashController extends GetxController {
  Duration duration = Duration(seconds: 2);
  String message = "REMINDER";
  AnimationController animationController;
  Animation<String> animation;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

  }

  final Shader linearGradient = LinearGradient(
    colors: <Color>[HexColor.fromHex("#bdc3c7"), HexColor.fromHex("#2c3e50")],
  ).createShader(Rect.fromLTWH(0.0, 0.0, 200.0, 70.0));

  void configName(Function name) {

  }

  void pushToHomeScreen() {
    Get.off(HomeView());
  }
}
