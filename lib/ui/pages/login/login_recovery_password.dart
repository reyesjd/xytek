import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/ui/widgets/custom_snackbar.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_text_field.dart';

// ignore: must_be_immutable
class LoginRecoveryPassword extends StatelessWidget {
  final TextEditingController inputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginRecoveryPassword({Key? key}) : super(key: key);

  bool emailSend = false;

  bool isEmail(String em) {
    String p =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$";

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }

  resetPassword({email}) async {
    AuthController authController = Get.find();
    bool val = await authController.resetPassword(email: email);
    emailSend = val;
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
                                    keyText: Key("recoveryemailTf"),
                                    label:
                                        "Digite su correo para  recuperar la contrase??a",
                                    controller: inputController,
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
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.only(
                                        left: 30, right: 30, bottom: 30),
                                    child: Text(
                                        "Tenga en cuenta que debe ser el mismo correo registrado en la aplicaci??n",
                                        style: TextStyle(
                                            fontWeight: FontWeight.w300)),
                                  ),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 30, right: 30),
                                    child: Row(
                                      children: [
                                        WidgetButton(
                                            keyButton: Key("sendemailBtn"),
                                            text: "Enviar Correo",
                                            onPressed: () {
                                              /*Aqui se debe verificar si el email existe en la bd,
                                             y si el email si corresponde a un email*/
                                              final form =
                                                  _formKey.currentState;
                                              form!.save();
                                              if (form.validate()) {
                                                /*
                                                Get.to(() => LoginVerifyCode(
                                                    textEntered:
                                                        inputController.text,
                                                    onPressed: () => {
                                                          Get.to(() =>
                                                              LoginChangePassword())
                                                        }));
                                                        */
                                                resetPassword(
                                                    email:
                                                        inputController.text);

                                                if (emailSend) {
                                                  getCustomSnackbar(
                                                    "Email enviado",
                                                    "El correo se ha enviado correctamente al email ${inputController.text}",
                                                    type: CustomSnackbarType
                                                        .success,
                                                  );
                                                } else {
                                                  getCustomSnackbar(
                                                      "Email no enviado",
                                                      "El correo de recuperaci??n no se ha podido enviar",
                                                      type: CustomSnackbarType
                                                          .error);
                                                }
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
  }
}
