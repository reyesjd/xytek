import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/ui/widgets/custom_snackbar.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_text_field.dart';

class LoginVerifyCode extends StatelessWidget {
  final TextEditingController inputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginVerifyCode({Key? key}) : super(key: key);
  AuthController authController = Get.find();
  String phoneNumber = "";

  onPressed({code, phoneNumber}) async {
    try {
      await authController.verifyCodeSmS(
          smsCode: code, phoneNumber: phoneNumber);

      Get.offAndToNamed("/");
    } catch (e) {
      if (e == "invalid-verification-code") {
        getCustomSnackbar(
          "Error con el código",
          "El código ingresado no ha sido correcto",
          type: CustomSnackbarType.error,
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    phoneNumber = authController.phoneNumber;
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              color: Colors.black,
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back)),
          backgroundColor: Color.fromRGBO(244, 244, 244, 1),
          elevation: 0,
        ),
        body: Form(
            key: _formKey,
            child: Container(
              padding: EdgeInsets.all(20),
              color: Color.fromRGBO(244, 244, 244, 1),
              child: LayoutBuilder(
                builder: (context, constraint) {
                  return SingleChildScrollView(
                    child: ConstrainedBox(
                      constraints:
                          BoxConstraints(minHeight: constraint.maxHeight),
                      child: IntrinsicHeight(
                        child: Column(
                          children: <Widget>[
                            Expanded(
                              flex: 4,
                              child: Center(
                                child: Image(
                                  image: AssetImage("assets/logo/logo.png"),
                                  width: 130,
                                  height: 130,
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 6,
                              child: Center(
                                child: Column(
                                  children: [
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 30, right: 30),
                                      child: Text(
                                          "Ingresa el codigó de 5 digitos que enviamos a " +
                                              phoneNumber,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300)),
                                    ),
                                    WidgetTextField(
                                      keyText: Key("verificationcodeTf"),
                                      label: "",
                                      controller: inputController,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Por favor ingrese el codigo de 5 digitos.";
                                        } else if (value.length != 5) {
                                          return "El codigo ingresado no es de 5 digitos, por favcr rectifiquelo.";
                                        }
                                      },
                                      obscure: false,
                                      digitsOnly: true,
                                    ),
                                    Container(
                                      padding:
                                          EdgeInsets.only(left: 30, right: 30),
                                      child: Row(
                                        children: [
                                          WidgetButton(
                                              keyButton: Key("verifyBtn"),
                                              text: "Continuar",
                                              onPressed: () {
                                                onPressed(
                                                    code: inputController.text,
                                                    phoneNumber: phoneNumber);
                                              },
                                              typeMain: true),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            )));
  }
}
