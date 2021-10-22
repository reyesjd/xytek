import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/ui/pages/launch_page.dart';
import 'package:xytek/ui/pages/login/login_main_page.dart';
import 'package:xytek/ui/pages/main_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),

      home: GetX<AuthController>(builder: (controller) {
        if (!controller.loadedApp) {
          return LaunchPage();
        } else {
          if (!controller.userIDLogged.isEmpty) {
            return MainPage();
          } else {
            return LoginMainPage();
          }
        }
      }),
    );
  }
}
