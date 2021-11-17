import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/data/models/locations_model.dart';
import 'package:xytek/data/models/user_model.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/domain/controllers/authentication/storage_controller.dart';
import 'package:xytek/ui/pages/updateuserdata/directions_page.dart';

import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_text_align.dart';
import 'package:xytek/ui/widgets/widget_text_field.dart';

import 'maps_page.dart';

class MyData extends StatelessWidget {
  MyData({Key? key}) : super(key: key) {
    initValues();
  }

  final TextEditingController nameTextController = TextEditingController();
  final TextEditingController emailTextController = TextEditingController();
  final TextEditingController phoneNTextController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var dropdownValue = "Nueva".obs;
  RxList<String> direcciones = RxList<String>([]);
  AuthController authController = Get.find();
  StorageController storageController = Get.find();

  initValues() {
    UserModel user = authController.userModelLogged;
    nameTextController.text = user.name;
    emailTextController.text = user.email;
    phoneNTextController.text = "${user.phoneNumber}";
    print(user.locationsModel);
    for (LocationsModel location in user.locationsModel!) {
      direcciones.add(location.nickName);
    }
    direcciones.add("Nueva");
    if (direcciones.length > 1) {
      dropdownValue.value = direcciones[0];
    }
  }

  update() async {
    UserModel user = authController.userModelLogged;
    await storageController.updateUser(
        uid: user.uid,
        phoneNumber: int.parse(phoneNTextController.text),
        name: nameTextController.text);
    authController.userModelLoggedOBX.update((value) {
      user.update(
          email: emailTextController.text,
          name: nameTextController.text,
          phoneNumber: phoneNTextController.text);
    });
    Get.back();
    Get.snackbar("Actualización Exitosa",
        "Los datos digitados han sido actualizados correctamente",
        backgroundColor: Colors.green);
  }

  bool isEmail(String em) {
    String p =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$";
    RegExp regExp = RegExp(p);
    return regExp.hasMatch(em);
  }

  getLocationByDropDow() {
    List lista = authController.userModelLogged.locationsModel as List;
    if (dropdownValue.value != "Nueva") {
      return lista
          .where((element) => element.nickName == dropdownValue.value)
          .first;
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Obx(() => Scaffold(
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
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          WidgetAlignText(text: "Datos de Cuenta", size: 18),
                          Container(
                            padding: EdgeInsets.only(top: 20),
                            child: TextFormField(
                              controller: emailTextController,
                              enabled: false,
                              decoration: InputDecoration(
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(30)),
                                labelStyle:
                                    TextStyle(fontWeight: FontWeight.bold),
                                labelText: "Correo Electronico",
                              ),
                            ),
                          ),
                        ],
                      ),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            WidgetAlignText(text: "Datos Personales", size: 18),
                            WidgetTextField(
                              label: "Nombre",
                              controller: nameTextController,
                              validator: (value) {},
                              obscure: false,
                              digitsOnly: false,
                            ),
                            WidgetTextField(
                              label: "Teléfono",
                              controller: phoneNTextController,
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
                                          var location = getLocationByDropDow();
                                          if (location != null) {
                                            if (location.type == "Complete") {
                                              Get.to(
                                                  () => DirectionsUpdateUser(),
                                                  arguments:
                                                      getLocationByDropDow());
                                            } else {
                                              Get.to(() => MapUpdateUser(),
                                                      arguments:
                                                          getLocationByDropDow())!
                                                  .catchError((e) {
                                                Get.snackbar(
                                                    "Error con Google Maps",
                                                    "No ha sido posible abrir google maps");
                                              });
                                            }
                                          } else {
                                            Get.to(() => DirectionsUpdateUser(),
                                                arguments:
                                                    getLocationByDropDow());
                                          }
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              size: 28,
                                            ),
                                            Text(
                                                dropdownValue.value == "Nueva"
                                                    ? "Agregar ubicación"
                                                    : "Editar ubicación",
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
                              onPressed: () {
                                update();
                              },
                              typeMain: true),
                        ],
                      )
                    ],
                  ),
                )
              ],
            ),
          ),
        )));
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
