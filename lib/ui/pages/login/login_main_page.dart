import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/ui/pages/login/login_number.dart';

import 'package:xytek/ui/pages/signup/first_register_page.dart';

import 'package:xytek/ui/widgets/widget_button.dart';
import 'login_by_credentials.dart';

class LoginMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        color: Color.fromRGBO(244, 244, 244, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Center(
              child: Image(
                image: AssetImage("assets/logo/logo.png"),
                width: 130,
                height: 130,
              ),
            ),
            Center(
              child: Column(
                children: [
                  Text(
                    "Ya falta poco!",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("¿Cómo deseas continuar?"),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      WidgetButton(
                          keyButton: Key("emailBtn"),
                          text: "E-mail",
                          onPressed: () {
                            Get.to(() => LoginCredentials());
                          },
                          typeMain: true),
                      WidgetButton(
                          keyButton: Key("phoneBtn"),
                          text: "Celular",
                          onPressed: () {
                            Get.to(() => LoginPhoneNumber());
                          },
                          typeMain: true),
                    ],
                  ),
                  Text(
                    "¿No tienes cuenta?",
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text("Registrate ya!"),
                  Row(
                    children: [
                      WidgetButton(
                          keyButton: Key("signupBtn"),
                          text: "Registrate",
                          onPressed: () {
                            Get.to(() => FirstRegisterPage());
                          },
                          typeMain: false),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
