import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/ui/pages/login/login_main_page.dart';
import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_text_field.dart';

class SecondRegisterPage extends StatelessWidget {
  final String typeLogin = "";
  final TextEditingController usuarioTextController = TextEditingController();
  final TextEditingController contrasenaTextController =
      TextEditingController();
  final TextEditingController confirmacionTextController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  SecondRegisterPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
        appBar: WidgetAppBarBack(actionButtonBack: () {
          Get.back();
        }).build(context),
        body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(20),
            color: Color.fromRGBO(244, 244, 244, 1),
            child: ListView(
              children: [
                SizedBox(
                  height: media.height - 130,
                  child: Column(
                    children: [
                      Container(
                        padding: EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          children: [
                            Expanded(
                              flex: 1,
                              child: Text(
                                "Ya casi está",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                            Expanded(
                              flex: 2,
                              child: Center(
                                child: Image(
                                  image: AssetImage("assets/logo/logo.png"),
                                  width: 130,
                                  height: 130,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            WidgetTextField(
                              label: "Usuario",
                              controller: usuarioTextController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Por favor ingrese su nombre";
                                }
                              },
                              obscure: false,
                              digitsOnly: false,
                            ),
                            WidgetTextField(
                              label: "Contraseña",
                              controller: contrasenaTextController,
                              validator: (value) {
                                return true;
                              },
                              obscure: false,
                              digitsOnly: false,
                            ),
                            WidgetTextField(
                              label: "Confirmar contraseña",
                              controller: confirmacionTextController,
                              validator: (value) {
                                return contrasenaTextController.text = value;
                              },
                              obscure: false,
                              digitsOnly: true,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [
                                  Text("Agregar dirección"),
                                  Icon(Icons.location_on_outlined)
                                ],
                              ),
                            ),
                            Row(
                              children: [
                                WidgetButton(
                                    text: "Registrarme!",
                                    onPressed: () {
                                      Get.to(() => LoginMainPage());
                                    },
                                    typeMain: true),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }
}
