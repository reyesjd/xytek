import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/data/models/locations_model.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/domain/controllers/authentication/storage_controller.dart';
import 'package:xytek/ui/pages/updateuserdata/maps_page.dart';
import 'package:xytek/ui/widgets/custom_snackbar.dart';

import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_text_field.dart';

// ignore: must_be_immutable
class DirectionsUpdateUser extends StatelessWidget {
  DirectionsUpdateUser({Key? key}) : super(key: key) {
    location = Get.arguments;
    initValues();
  }

  final TextEditingController departamento = TextEditingController();
  final TextEditingController ciudad = TextEditingController();
  final TextEditingController barrio = TextEditingController();
  final TextEditingController apodo = TextEditingController();
  final TextEditingController calle = TextEditingController();
  final TextEditingController numero = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  List<String> tiposCalle = ["Calle", "Carrera", "Diagonal", "Transversal"];
  var tipoCalle = "Calle".obs;

  var location = Get.arguments;

  initValues() {
    if (location != null) {
      LocationsModel locationsModel = location as LocationsModel;
      departamento.text = locationsModel.department!;
      ciudad.text = locationsModel.city!;
      apodo.text = locationsModel.nickName;
      barrio.text = locationsModel.neighborhood!;
      //calle.text=locationsModel.typ
      tipoCalle.value = locationsModel.typeLocation!;
      numero.text = "${locationsModel.numberLocation!}";
    }
  }

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
                      if (location == null)
                        Container(
                            padding:
                                EdgeInsets.only(left: 15, right: 15, top: 15),
                            child: TextButton(
                              style: TextButton.styleFrom(
                                primary: Colors.black,
                              ),
                              onPressed: () {
                                Get.to(() => MapUpdateUser());
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.location_on_outlined,
                                    size: 28,
                                  ),
                                  Text("Calcular ubicaci??n automaticamente",
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
                                  dropDown(
                                      icon: Icon(Icons.arrow_drop_down),
                                      initValue: tipoCalle,
                                      items: tiposCalle),
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
                                    ),
                                  ),
                                  Expanded(
                                    child: WidgetTextField(
                                      label: "Numer??",
                                      controller: numero,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Por favor ingrese su numer??";
                                        }
                                      },
                                      obscure: false,
                                      digitsOnly: true,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            WidgetTextField(
                              label: "Apodo de la direccion",
                              active: location == null ? true : false,
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
                              onPressed: () async {
                                final form = _formKey.currentState;
                                form!.save();
                                if (form.validate()) {
                                  AuthController authController = Get.find();
                                  StorageController storageController =
                                      Get.find();
                                  List l = authController
                                      .userModelLogged.locationsModel;

                                  if (location == null) {
                                    LocationsModel locationModel =
                                        LocationsModel(
                                            type: "Complete",
                                            nickName: apodo.text,
                                            city: ciudad.text,
                                            department: departamento.text,
                                            neighborhood: barrio.text,
                                            typeLocation: tipoCalle.value,
                                            numberLocation:
                                                int.parse(numero.text),
                                            street: calle.text);
                                    var verif = l.where((element) =>
                                        element.nickName == apodo.text);
                                    if (verif.isEmpty) {
                                      l.add(locationModel);
                                      await storageController.updateUser(
                                          uid: authController
                                              .userModelLogged.uid,
                                          locationsModel:
                                              l.map((e) => e.toMap()).toList());
                                      authController.userModelLogged
                                          .update(locationsModel: l);

                                      Get.close(2);
                                      getCustomSnackbar(
                                        "Actualizaci??n exitosa",
                                        " Se a??adio la ubicaci??n exitosamente",
                                        type: CustomSnackbarType.success,
                                      );
                                    } else {
                                      getCustomSnackbar(
                                        "Error agregando la ubicaci??n",
                                        "Ya existe una ubicaci??n con ese apodo",
                                        type: CustomSnackbarType.error,
                                      );
                                    }
                                  } else {
                                    LocationsModel locationModel =
                                        LocationsModel(
                                            type: "Complete",
                                            nickName: apodo.text,
                                            city: ciudad.text,
                                            department: departamento.text,
                                            neighborhood: barrio.text,
                                            typeLocation: tipoCalle.value,
                                            numberLocation:
                                                int.parse(numero.text),
                                            street: calle.text);
                                    l.removeWhere((element) =>
                                        element.nickName == location.nickName);
                                    l.add(locationModel);
                                    await storageController.updateUser(
                                        uid: authController.userModelLogged.uid,
                                        locationsModel:
                                            l.map((e) => e.toMap()).toList());
                                    authController.userModelLogged
                                        .update(locationsModel: l);
                                    Get.back();
                                    getCustomSnackbar(
                                      "Actualizaci??n exitosa",
                                      "La ubicaci??n se actualiz?? exitosamente",
                                      type: CustomSnackbarType.success,
                                    );
                                  }
                                }
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
