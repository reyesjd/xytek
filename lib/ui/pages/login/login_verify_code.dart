import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_text_field.dart';

class LoginVerifyCode extends StatelessWidget {
  final String textEntered;
  final TextEditingController inputController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  LoginVerifyCode({Key? key, required this.textEntered}) : super(key: key);

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
                                    Container(
                                      alignment: Alignment.topLeft,
                                      padding:
                                          EdgeInsets.only(left: 30, right: 30),
                                      child: Text(
                                          "Ingresa el codigó de 5 digitos que enviamos a " +
                                              textEntered,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w300)),
                                    ),
                                    WidgetTextField(
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
                                              text: "Continuar",
                                              onPressed: () {
                                                final form =
                                                    _formKey.currentState;
                                                form!.save();
                                                if (form.validate()) {
                                                  print("hola");
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
            )));
  }
}
