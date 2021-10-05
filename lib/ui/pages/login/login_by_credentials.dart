import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_text_field.dart';

class LoginCredentials extends StatelessWidget {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();

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
                            flex: 3,
                            child: Center(
                              child: Image(
                                image: AssetImage("assets/logo/logo.png"),
                                width: 130,
                                height: 130,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Center(
                              child: Column(
                                children: [
                                  WidgetTextField(
                                    label: "Usuario",
                                    controller: _email,
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
                                      label: "Contraseña",
                                      controller: _password,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Por favor ingrese una contraseña.";
                                        }
                                      },
                                      obscure: true,
                                      digitsOnly: false),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 30, right: 30),
                                    child: Row(
                                      children: [
                                        WidgetButton(
                                            text: "Iniciar Sesión",
                                            onPressed: () {
                                              final form =
                                                  _formKey.currentState;
                                              form!.save();
                                              if (form.validate()) {
                                                //Aqui se encvia al home
                                              }
                                            },
                                            typeMain: true),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.all(16.0),
                                      primary: Colors.grey,
                                    ),
                                    onPressed: () {},
                                    child:
                                        const Text('¿Olvidaste tu contraseña?'),
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
