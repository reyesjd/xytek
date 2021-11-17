import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/ui/pages/signup/second_register_page.dart';

import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_text_field.dart';

class FirstRegisterPage extends StatelessWidget {
  final String typeLogin = "";
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController phoneNTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  FirstRegisterPage({Key? key}) : super(key: key);

  bool isEmail(String em) {
    String p =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$";
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);
  }

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
              key: Key("signLv"),
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
                              flex: 2,
                              child: Text(
                                "Crea tu Nueva Cuenta",
                                overflow: TextOverflow.ellipsis,
                                maxLines: 5,
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
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
                      ),
                      Expanded(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            WidgetTextField(
                              keyText: Key("nameTf"),
                              label: "Nombre Completo",
                              controller: nameTextController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Por favor ingrese su nombre";
                                }
                              },
                              obscure: false,
                              digitsOnly: false,
                            ),
                            WidgetTextField(
                              keyText: Key("emailTf"),
                              label: "Correo electronico",
                              controller: emailTextController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Por favor ingrese su E-mail.";
                                } else if (!isEmail(value)) {
                                  return "Por favor ingrese un E-mail valido.";
                                }
                              },
                              obscure: false,
                              digitsOnly: false,
                            ),
                            WidgetTextField(
                              keyText: Key("phoneTf"),
                              label: "Telefono",
                              controller: phoneNTextController,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Por favor ingrese su numero celular.";
                                } else if (value.length != 10) {
                                  return "Por favor ingrese un numero celular valido.";
                                }
                              },
                              obscure: false,
                              digitsOnly: true,
                            ),
                            Row(
                              children: [
                                WidgetButton(
                                    keyButton: Key("nextBtn"),
                                    text: "Siguiente",
                                    onPressed: () {
                                      final form = _formKey.currentState;
                                      form!.save();
                                      if (form.validate()) {
                                        Get.to(() => SecondRegisterPage(),
                                            arguments: [
                                              emailTextController.text,
                                              nameTextController.text,
                                              phoneNTextController.text
                                            ]);
                                      }
                                    },
                                    typeMain: false),
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
