import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/ui/widgets/button_widget.dart';

class LoginMainPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        padding: EdgeInsets.all(20),
        color: Color.fromRGBO(244, 244, 244, 1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Center(
                child: Image(
                  image: AssetImage("assets/logo/logo.png"),
                  width: 130,
                  height: 130,
                ),
              ),
            ),
            Expanded(
              flex: 1,
              child: Center(
                child: Column(
                  children: [
                    Text(
                      "Ya falta poco!",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("¿Cómo deseas continuar?"),
                    Row(
                      children: [
                        ButtonMain(
                            text: "Usuarios y Contraseñas",
                            onPressed: () {
                              /*Get.to(() => LoginCredentials());*/
                              print("hola");
                            },
                            type_main: true),
                      ],
                    ),
                    Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ButtonMain(
                            text: "E-mail", onPressed: () {}, type_main: true),
                        ButtonMain(
                            text: "Celular", onPressed: () {}, type_main: true),
                      ],
                    ),
                    Text(
                      "¿No tienes cuenta?",
                      style: TextStyle(fontWeight: FontWeight.bold),
                    ),
                    Text("Registrate ya!"),
                    Row(
                      children: [
                        ButtonMain(
                            text: "Registrate",
                            onPressed: () {},
                            type_main: false),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
