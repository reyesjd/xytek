import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';

class LaunchPage extends StatelessWidget {
  waitforUserLogged() async {
    AuthController authController = Get.find();

    await authController.init();
    authController.setloadedApp = true;
  }

  @override
  Widget build(BuildContext context) {
    waitforUserLogged();
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.bottomCenter,
            end: Alignment.topCenter,
            colors: <Color>[
              Color.fromRGBO(134, 217, 197, 1.0),
              Color.fromRGBO(244, 244, 244, 1.0),
            ],
            tileMode: TileMode.clamp,
          ),
        ),
        child: Center(
          child: Image(
            image: AssetImage("assets/logo/logo.png"),
            width: 130,
            height: 130,
          ),
        ),
      ),
    );
  }
}
