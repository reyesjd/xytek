import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/ui/pages/login/login_verify_code.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_text_field.dart';

class LoginEmailOrNumber extends StatelessWidget {
  final String typeLogin;
  final TextEditingController inputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginEmailOrNumber({Key? key, required this.typeLogin}) : super(key: key);

  bool isEmail(String em) {
    String p =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$";

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
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
                                    label: (typeLogin == "email")
                                        ? "¿Cuál es tu E-Mail?"
                                        : "¿Cuál es tu número celular?",
                                    controller: inputController,
                                    validator: (value) {
                                      if (typeLogin == "email") {
                                        if (value!.isEmpty) {
                                          return "Por favor ingrese su E-mail.";
                                        } else if (!isEmail(value)) {
                                          return "Por favor ingrese un E-mail valido.";
                                        }
                                      } else {
                                        if (value!.isEmpty) {
                                          return "Por favor ingrese su numero celular.";
                                        } else if (value.length != 10) {
                                          return "Por favor ingrese un numero celular valido.";
                                        }
                                      }
                                    },
                                    obscure: false,
                                    digitsOnly: !(typeLogin == "email"),
                                  ),
                                  Container(
                                    alignment: Alignment.topLeft,
                                    padding: EdgeInsets.only(
                                        left: 30, right: 30, bottom: 30),
                                    child: Text(
                                        ((typeLogin == "email")
                                            ? "Enviaremos un codigó de 5 digitos al e-mail ingresado."
                                            : "Enviaremos un codigó de 5 digitos al numero celular ingresado."),
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
                                                Get.to(() => LoginVerifyCode(
                                                      textEntered:
                                                          inputController.text,
                                                    ));
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
