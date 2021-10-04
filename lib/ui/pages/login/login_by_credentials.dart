import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/ui/widgets/TextField_Widget.dart';
import 'package:xytek/ui/widgets/button_widget.dart';

class LoginCredentials extends StatelessWidget {
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
        body: Container(
          padding: EdgeInsets.all(20),
          color: Color.fromRGBO(244, 244, 244, 1),
          child: LayoutBuilder(
            builder: (context, constraint) {
              return SingleChildScrollView(
                child: ConstrainedBox(
                  constraints: BoxConstraints(minHeight: constraint.maxHeight),
                  child: IntrinsicHeight(
                    child: Column(
                      children: <Widget>[
                        Expanded(
                          flex: 3,
                          child: Center(
                            child: Container(
                              child: Image(
                                image: AssetImage("assets/logo/logo.png"),
                                width: 130,
                                height: 130,
                              ),
                            ),
                          ),
                        ),
                        Expanded(
                          flex: 7,
                          child: Center(
                            child: Column(
                              children: [
                                TextFieldWidget(
                                    label: "Usuario",
                                    controller: TextEditingController(),
                                    validator: (value) {
                                      print(value);
                                    },
                                    obscure: false),
                                TextFieldWidget(
                                    label: "Contraseña",
                                    controller: TextEditingController(),
                                    validator: (value) {
                                      print(value);
                                    },
                                    obscure: true),
                                Container(
                                  padding: EdgeInsets.only(left: 30, right: 30),
                                  child: Row(
                                    children: [
                                      ButtonMain(
                                          text: "Iniciar Sesión",
                                          onPressed: () {
                                            /*Get.to(() => LoginCredentials());*/
                                            print("hola");
                                          },
                                          type_main: true),
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
        ));
  }
}
