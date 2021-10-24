import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/ui/pages/login/login_verify_code.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_text_field.dart';

class LoginPhoneNumber extends StatelessWidget {
  final TextEditingController inputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  LoginPhoneNumber({
    Key? key,
  }) : super(key: key);

  actionInStream(data) {
    if (data.runtimeType == String) {
      String val = data as String;
      if (val.contains("Error:")) {
        if (val.contains("too-many-requests")) {
          Get.snackbar("Error enviando el código",
              "Ya has realizado muchas peticiones, intentalo más tarde",
              backgroundColor: Colors.red);
        } else {
          if (val.contains("Number phone no registered")) {
            Get.snackbar("Error enviando el código",
                "El número de telefono ingresado no se encuentra registrado",
                backgroundColor: Colors.red);
          } else {
            Get.snackbar("Error enviando el código", val.substring(6),
                backgroundColor: Colors.red);
          }
        }
      } else {
        Get.to(() => LoginVerifyCode());

        Get.snackbar("Verificacíon automatica",
            "Intentando comprobar el código automaticamente",
            showProgressIndicator: true, duration: Duration(seconds: 10));
      }
    } else {
      if (Get.isSnackbarOpen!) {
        Get.close(3);
      } else {
        Get.close(2);
      }
    }
  }

  onPressed({phoneNumber}) async {
    AuthController authController = Get.find();
    authController.phoneNumber = phoneNumber;
    try {
      await authController.logingByPhoneNumber(
          phoneNumber: phoneNumber, actionInStream: actionInStream);
    } catch (e) {
      print(e);
    }
  }

  @override
  Widget build(BuildContext context) {
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
                                  WidgetTextField(
                                    label: "¿Cuál es tu número celular?",
                                    controller: inputController,
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
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.only(
                                        left: 30, right: 30, bottom: 30),
                                    child: Text(
                                        ("Enviaremos un codigó de 5 digitos al numero celular ingresado."),
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 30, right: 30),
                                    child: Row(
                                      children: [
                                        WidgetButton(
                                            text: "Enviar Código",
                                            onPressed: () {
                                              /*Aqui se debe verificar si el email existe en la bd,
                                             y si el email si corresponde a un email*/
                                              final form =
                                                  _formKey.currentState;
                                              form!.save();
                                              if (form.validate()) {
                                                onPressed(
                                                    phoneNumber:
                                                        inputController.text);
                                              }
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
          ),
        ));

    /*

    return GetX<AuthController>(
      builder: (AuthController controller) {
        // ignore: invalid_use_of_protected_member
        bool isNotUser = controller.credential.whereType<String>().isEmpty;
        bool isNotError =
            controller.credential.whereType<FirebaseAuthException>().isEmpty;

        if (!isNotError) {
          message = controller.credential
              .whereType<FirebaseAuthException>()
              .toList()[0]
              .code;
          Get.snackbar("Error", message);
        }
        if (isNotError && isNotUser) {
          return LoginVerifyCode(phoneNumber: inputController.text);
        }
        return pageLoginPhoneNumber();
      },
    );*/
  }
}