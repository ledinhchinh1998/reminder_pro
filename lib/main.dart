import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:note_app_pro/app/modules/splash/splash_view.dart';

import 'app/data/helper/mldb_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await MLDBHelper.initDb();
  runApp(GetMaterialApp(
    debugShowCheckedModeBanner: false,
    //initialRoute: '/',
    theme: ThemeData(
      // Define the default brightness and colors.
      brightness: Brightness.dark,
      primaryColor: Colors.blue,
      accentColor: Colors.blue,
    ),
    defaultTransition: Transition.fade,
    //getPages: MyRoutes.routes,
    home: SplashView(),
  ));
}
