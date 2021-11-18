import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/ui/pages/login/login_main_page.dart';
import 'package:xytek/ui/pages/profile/my_shoppings.dart';
import 'package:xytek/ui/pages/profile/shopper_page.dart';

// ignore: must_be_immutable
class CustomDrawer extends StatelessWidget {
  AuthController authController = Get.find();

  @override
  Widget build(BuildContext context) {
    return Drawer(
      key: Key("drawer"),
      child: ListView(
        children: <Widget>[
          DrawerHeader(
              key: Key("menuDh"),
              child: authController.userIDLogged.isEmpty
                  ? TextButton(
                      key: Key("signinBtn"),
                      onPressed: () {
                        Get.to(() => LoginMainPage());
                      },
                      child: Text(
                        "Iniciar Sesión",
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    )
                  : TextButton(
                      key: Key("profileBtn"),
                      onPressed: () {
                        Get.to(() => Shopper());
                      },
                      child: Text(
                        authController.userModelLogged.name,
                        style: TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
              decoration: BoxDecoration(
                color: Colors.teal,
              )),
          ListTile(
            title: Text("Inicio"),
            onTap: () {
              Get.back();
            },
          ),
          if (authController.userIDLogged.isNotEmpty)
            ListTile(
              key: Key("history"),
              title: Text("Historial"),
              onTap: () {
                Get.to(() => MyShoppings());
              },
            ),
        ],
      ),
    );
  }
}
