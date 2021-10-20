import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/data/models/user_model.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_text_field.dart';

class SecondRegisterPage extends StatelessWidget {
  final String typeLogin = "";
  dynamic argumentData = Get.arguments;
  final TextEditingController userTextController = TextEditingController();
  final TextEditingController passTextController = TextEditingController();
  final TextEditingController confirPassTextController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  SecondRegisterPage({Key? key}) : super(key: key);

  void singUp() async {
    
    final form = _formKey.currentState;
    form!.save();
    if (form.validate()) {
      try {
        AuthController authController = Get.find();
        UserModel newUser = UserModel(
            email: argumentData[0],
            name: argumentData[1],
            phoneNumber: int.parse(argumentData[2]),
            user: userTextController.text,
            password: passTextController.text);
        await authController.signUp(newUser);
      } catch (e) {
        print(e);
      }
    }
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
                              controller: userTextController,
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
                              controller: passTextController,
                              validator: (value) {},
                              obscure: false,
                              digitsOnly: false,
                            ),
                            WidgetTextField(
                              label: "Confirmar contraseña",
                              controller: confirPassTextController,
                              validator: (value) {
                                if (passTextController.text != value) {
                                  return "Error las contraseñas ";
                                }
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
                                      singUp();
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
