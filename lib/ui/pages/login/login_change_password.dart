import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/ui/pages/login/login_by_credentials.dart';
import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_text_field.dart';

class LoginChangePassword extends StatelessWidget {
  final String typeLogin = "";
  final TextEditingController nombreTextController = TextEditingController();
  final TextEditingController correoTextController = TextEditingController();
  final TextEditingController telefonoTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginChangePassword({Key? key}) : super(key: key);

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
                      Expanded(
                          flex: 2,
                          child: Container(
                            padding: EdgeInsets.only(left: 10, right: 10),
                            child: Row(
                              children: [
                                Expanded(
                                  flex: 2,
                                  child: Text(
                                    "Cambiar \nContraseña",
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 5,
                                    style: TextStyle(
                                        fontSize: 25,
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
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
                              ],
                            ),
                          )),
                      Expanded(
                        flex: 4,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            WidgetTextField(
                              label: "Contraseña nueva",
                              controller: nombreTextController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Por favor ingrese la nueva contraseña";
                                }
                              },
                              obscure: true,
                              digitsOnly: false,
                            ),
                            WidgetTextField(
                              label: "Confirmar contraseña",
                              controller: nombreTextController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Por favor confirme la contraseña";
                                }
                              },
                              obscure: true,
                              digitsOnly: false,
                            ),
                            Expanded(
                                flex: 1,
                                child: Row(
                                  children: [
                                    WidgetButton(
                                        text: "Cambiar Contraseña",
                                        onPressed: () {
                                          Get.to(() => LoginCredentials());
                                        },
                                        typeMain: false),
                                  ],
                                ))
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
