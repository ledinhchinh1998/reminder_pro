
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:note_app_pro/app/modules/splash/splash_controller.dart';
import 'package:note_app_pro/app/utils/type_write_tween.dart';

class SplashView extends StatefulWidget {
  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashView> with TickerProviderStateMixin {

  final controller = Get.put(SplashController());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    controller.animationController = AnimationController(vsync: this,duration: controller.duration);
    controller.animation = TypewriterTween(end: controller.message).animate(controller.animationController);
    controller.animationController.forward().whenComplete(() {
      controller.update();
      controller.pushToHomeScreen();
    });
    return Scaffold(
      body: Container(
        color: Colors.black,
        child: GetBuilder<SplashController>(
          init: SplashController(),
          builder: (_){
            return Center(
                child: Container(
                  padding: EdgeInsets.all(20),
                  child: AnimatedBuilder(
                    animation: controller.animation,
                    builder: (context, child) {
                      return Text(
                          '${controller.animation.value}',
                          style: GoogleFonts.adamina(
                            fontSize: 44,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 2,
                            foreground: Paint()..shader = _.linearGradient,
                          )
                      );
                    },
                  ),
                )
            );
          },
        ),
      ),
    );
  }
}
