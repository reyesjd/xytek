import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/ui/pages/home/main.dart';
import 'package:xytek/ui/pages/login/login_main_page.dart';
import 'package:xytek/ui/pages/profile/shopper_page.dart';

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
              child: !authController.userIDLogged.isEmpty
                  ? TextButton(
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
                    )
                  : TextButton(
                      key: Key("profileBtn"),
                      onPressed: () {
                        Get.to(() => LoginMainPage());
                      },
                      child: Text(
                        "Iniciar Sesión",
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
              Get.to(() => Main());
            },
          ),
          ListTile(
            title: Text("Historial"),
            onTap: () {},
          ),
        ],
      ),
    );
  }
}
