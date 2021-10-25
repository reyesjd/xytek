import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/ui/pages/updateuserdata/directions_page.dart';

import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_text_align.dart';
import 'package:xytek/ui/widgets/widget_text_field.dart';

class MyData extends StatelessWidget {
  MyData({Key? key}) : super(key: key);

  final String typeLogin = "";
  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController apellidosTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController telefonoTextController = TextEditingController();
  final TextEditingController phoneNTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var dropdownValue = "Mi casa".obs;
  List<String> direcciones = ["Mi casa", "Trabajo", "Tienda"];

  bool isEmail(String em) {
    String p =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$";
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);
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
                      WidgetAlignText(text: "Mis Datos", size: 26),
                      Expanded(
                        flex: 1,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            WidgetAlignText(text: "Datos de Cuenta", size: 18),
                            WidgetTextField(
                              label: "Correo electronico",
                              controller: emailTextController,
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
                          ],
                        ),
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            WidgetAlignText(text: "Datos Personales", size: 18),
                            WidgetTextField(
                              label: "Nombres",
                              controller: nameTextController,
                              validator: (value) {},
                              obscure: false,
                              digitsOnly: false,
                            ),
                            WidgetTextField(
                              label: "Apellidos",
                              controller: apellidosTextController,
                              validator: (value) {},
                              obscure: false,
                              digitsOnly: false,
                            ),
                            WidgetTextField(
                              label: "Teléfono",
                              controller: telefonoTextController,
                              validator: (value) {},
                              obscure: false,
                              digitsOnly: true,
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                          flex: 1,
                          child: Column(
                            children: [
                              WidgetAlignText(text: "Direcciones", size: 18),
                              Row(
                                children: [
                                  dropDown(
                                      icon: Icon(Icons.arrow_drop_down),
                                      initValue: dropdownValue,
                                      items: direcciones),
                                  Container(
                                      padding: EdgeInsets.only(
                                          left: 15, right: 15, top: 15),
                                      child: TextButton(
                                        style: TextButton.styleFrom(
                                          primary: Colors.black,
                                        ),
                                        onPressed: () {
                                          Get.to(() => Directions());
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              size: 28,
                                            ),
                                            Text("Agregar direccion",
                                                style: TextStyle(
                                                    fontSize: 16,
                                                    fontWeight:
                                                        FontWeight.w400))
                                          ],
                                        ),
                                      ))
                                ],
                              )
                            ],
                          )),
                      Row(
                        children: [
                          WidgetButton(
                              text: "Guardar Cambios",
                              onPressed: () {},
                              typeMain: true),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        ));
  }

  Widget dropDown({initValue, List<String> items = const [], icon}) {
    return Container(
      padding: EdgeInsets.only(left: 30, right: 30),
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(30.0),
          border: Border.all(
            color: Colors.grey,
            width: 1.0,
          )),
      child: ObxValue(
        (data) => DropdownButton(
          value: initValue.value,
          icon: icon,
          underline: SizedBox(),
          items: items.map<DropdownMenuItem<String>>((String items) {
            return DropdownMenuItem(value: items, child: Text(items));
          }).toList(),
          onChanged: (newValue) {
            initValue.value = newValue;
          },
        ), // Rx has a _callable_ function! You could use (flag) => data.value = flag,
        initValue as RxString,
      ),
    );
  }
}
