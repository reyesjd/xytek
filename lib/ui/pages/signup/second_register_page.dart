import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/data/models/user_model.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/ui/pages/signup/maps_page.dart';
import 'package:xytek/ui/widgets/custom_snackbar.dart';
import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_text_field.dart';

// ignore: must_be_immutable
class SecondRegisterPage extends StatelessWidget {
  final String typeLogin = "";
  dynamic argumentData = Get.arguments;
  final TextEditingController userTextController = TextEditingController();
  final TextEditingController passTextController = TextEditingController();
  final TextEditingController confirPassTextController =
      TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;

  bool registred = false;
  String errorMessage = "No ha sido posible registrarte";

  SecondRegisterPage({Key? key}) : super(key: key);

  singUp() async {
    final form = _formKey.currentState;
    form!.save();
    if (form.validate()) {
      AuthController authController = Get.find();
      try {
        UserModel newUser;
        if (authController.userLocation != null) {
          newUser = UserModel(
              email: argumentData[0],
              name: argumentData[1],
              phoneNumber: int.parse(argumentData[2]),
              user: userTextController.text,
              password: passTextController.text,
              isSeller: false,
              salesProductsReferences: [],
              locationsModel: [authController.userLocation!]);
        } else {
          newUser = UserModel(
              email: argumentData[0],
              name: argumentData[1],
              phoneNumber: int.parse(argumentData[2]),
              user: userTextController.text,
              password: passTextController.text,
              isSeller: false,
              salesProductsReferences: [],
              locationsModel: []);
        }

        var val = await authController.signUp(newUser);
        registred = val;
      } catch (e) {
        switch (e) {
          case "email-already-in-use":
            {
              errorMessage =
                  "El correo que intenta utilizar ya se encuentra registrado en la aplicaci??n";
              break;
            }
          case "invalid-email:":
            {
              errorMessage = "El correo que intenta utilizar no es v??lido";
              break;
            }
          case "operation-not-allowed":
            {
              // errorMessage="El correo que intenta utilizar no es v??lido";
              break;
            }
          case "weak-password":
            {
              errorMessage = "La contrase??a que ingres?? es muy d??bil";
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
              key: Key("signupLv"),
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
                                "Ya casi est??",
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
                              keyText: Key("userTf"),
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
                              keyText: Key("passwordTf"),
                              label: "Contrase??a",
                              controller: passTextController,
                              validator: (value) {},
                              obscure: true,
                              digitsOnly: false,
                            ),
                            WidgetTextField(
                              keyText: Key("confirpassTf"),
                              label: "Confirmar contrase??a",
                              controller: confirPassTextController,
                              validator: (value) {
                                if (passTextController.text != value) {
                                  return "Error las contrase??as ";
                                }
                              },
                              obscure: true,
                              digitsOnly: false,
                            ),
                            GestureDetector(
                              onTap: () {
                                Get.to(() => MapSignUpUser());
                              },
                              child: Container(
                                padding: EdgeInsets.only(left: 10, right: 10),
                                child: Row(
                                  children: [
                                    Text("Agregar direcci??n"),
                                    Icon(Icons.location_on_outlined)
                                  ],
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                Obx(
                                  () => WidgetButton(
                                    loading: loading,
                                    keyButton: Key("signupBtn"),
                                    text: "Registrarme!",
                                    onPressed: () async {
                                      if (!loading) {
                                        loading = true;
                                        final form = _formKey.currentState;
                                        form!.save();
                                        if (form.validate()) {
                                          await singUp();
                                          if (registred) {
                                            Get.close(2);
                                            //Get.offAllNamed("/");
                                            getCustomSnackbar(
                                              "Registro exitoso",
                                              "Has sido registrado satisfactoriamente en la aplicaci??n",
                                              type: CustomSnackbarType.success,
                                            );
                                          } else {
                                            getCustomSnackbar(
                                              "Error al intentar Registrarte",
                                              errorMessage,
                                              type: CustomSnackbarType.error,
                                            );
                                          }
                                        }
                                        loading = false;
                                      }
                                    },
                                    typeMain: true,
                                  ),
                                )
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
