import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/ui/pages/updateuserdata/maps_page.dart';

import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_text_field.dart';

class Directions extends StatelessWidget {
  Directions({Key? key}) : super(key: key);

  final String typeLogin = "";
  final TextEditingController departamento = TextEditingController();
  final TextEditingController ciudad = TextEditingController();
  final TextEditingController barrio = TextEditingController();
  final TextEditingController apodo = TextEditingController();
  final TextEditingController calle = TextEditingController();
  final TextEditingController numero = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<String> tiposCalle = ["Calle", "Carrera", "Diagonal", "Transversal"];
  var tipoCalle = "Calle".obs;

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
                      Container(
                          padding: EdgeInsets.only(left: 10, right: 10),
                          child: Align(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              "Direcciones",
                              style: TextStyle(
                                  fontSize: 25, fontWeight: FontWeight.bold),
                            ),
                          )),
                      Container(
                          padding:
                              EdgeInsets.only(left: 15, right: 15, top: 15),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              primary: Colors.black,
                            ),
                            onPressed: () {
                              Get.to(() => Maps());
                            },
                            child: Row(
                              children: [
                                Icon(
                                  Icons.location_on_outlined,
                                  size: 28,
                                ),
                                Text("Calcular ubicación automaticamente",
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400))
                              ],
                            ),
                          )),
                      Expanded(
                          child: Container(
                        padding: EdgeInsets.only(left: 15, right: 15),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            WidgetTextField(
                              label: "Departamento",
                              controller: departamento,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Por favor ingrese su departamento";
                                }
                              },
                              obscure: false,
                              digitsOnly: false,
                            ),
                            WidgetTextField(
                              label: "Municipio o Ciudad",
                              controller: ciudad,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Por favor ingrese su municipio o ciudad";
                                }
                              },
                              obscure: false,
                              digitsOnly: false,
                            ),
                            WidgetTextField(
                              label: "Barrio o Localidad",
                              controller: barrio,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Por favor ingrese su barrio";
                                }
                              },
                              obscure: false,
                              digitsOnly: false,
                            ),
                            Container(
                              padding: EdgeInsets.only(left: 10, right: 10),
                              child: Row(
                                children: [
                                  Expanded(
                                      child: dropDown(
                                          icon: Icon(Icons.arrow_drop_down),
                                          initValue: tipoCalle,
                                          items: tiposCalle)),
                                  Expanded(
                                      child: WidgetTextField(
                                    label: "Calle",
                                    controller: calle,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Por favor ingrese su calle";
                                      }
                                    },
                                    obscure: false,
                                    digitsOnly: false,
                                  )),
                                  Expanded(
                                      child: WidgetTextField(
                                    label: "Numeró",
                                    controller: numero,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Por favor ingrese su numeró";
                                      }
                                    },
                                    obscure: false,
                                    digitsOnly: true,
                                  )),
                                ],
                              ),
                            ),
                            WidgetTextField(
                              label: "Apodo de la direccion",
                              controller: apodo,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Por favor ingrese un apodo para la direccion";
                                }
                              },
                              obscure: false,
                              digitsOnly: false,
                            ),
                          ],
                        ),
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
      padding: EdgeInsets.only(left: 5),
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
