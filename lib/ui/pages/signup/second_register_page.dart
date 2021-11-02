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
  bool registred = false;
  String errorMessage = "No ha sido posible registrarte";

  SecondRegisterPage({Key? key}) : super(key: key);

  singUp() async {
    final form = _formKey.currentState;
    form!.save();
    if (form.validate()) {
      AuthController authController = Get.find();
      try {
        UserModel newUser = UserModel(
            email: argumentData[0],
            name: argumentData[1],
            phoneNumber: int.parse(argumentData[2]),
            user: userTextController.text,
            password: passTextController.text,
            isSeller: false,
            salesProducts: [],
            coordinates: "0,0");
        var val = await authController.signUp(newUser);
        registred = val;
      } catch (e) {
        switch (e) {
          case "email-already-in-use":
            {
              errorMessage =
                  "El correo que intenta utilizar ya se encuentra registrado en la aplicación";
              break;
            }
          case "invalid-email:":
            {
              errorMessage = "El correo que intenta utilizar no es válido";
              break;
            }
          case "operation-not-allowed":
            {
              // errorMessage="El correo que intenta utilizar no es válido";
              break;
            }
          case "weak-password":
            {
              errorMessage = "La contraseña que ingresó es muy débil";
              break;
            }
        }
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
                              obscure: true,
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
                              obscure: true,
                              digitsOnly: false,
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
                                    onPressed: () async {
                                      await singUp();
                                      if (registred) {
                                        Get.close(2);
                                        //Get.offAllNamed("/");
                                        Get.snackbar("Registro exitoso",
                                            "Has sido registrado satisfactoriamente en la aplicación",
                                            backgroundColor: Colors.green);
                                      } else {
                                        Get.snackbar(
                                            "Error al intentar Registrarte",
                                            errorMessage,
                                            backgroundColor: Colors.red);
                                      }
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
