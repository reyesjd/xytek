import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/data/models/product_model.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/domain/controllers/authentication/storage_controller.dart';
import 'package:xytek/ui/widgets/custom_snackbar.dart';

import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_text_align.dart';
import 'package:xytek/ui/widgets/widget_text_field.dart';

// ignore: must_be_immutable
class NewProduct extends StatelessWidget {
  NewProduct({Key? key}) : super(key: key);

  final TextEditingController name = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController urlImage = TextEditingController();
  final TextEditingController amountAvalaible = TextEditingController();
  final StorageController storageController = Get.find();
  final AuthController authController = Get.find();
  final _loading = false.obs;

  bool get loading => _loading.value;

  set loading(bool value) {
    _loading.value = value;
  }

  final _formKey = GlobalKey<FormState>();
  var dropdownValue = "Placas Base".obs;
  List<String> categorias = ProductModel.getCategorias();

  void handlerAddProduct() async {
    loading = true;
    try {
      var user = authController.userModelLogged;
      await storageController.addNewProduct(
          name: name.text,
          category: dropdownValue.value,
          description: description.text,
          price: int.parse(price.text),
          urlImage: urlImage.text,
          user: user,
          amountAvalaible: int.parse(amountAvalaible.text));

      Get.back();
      getCustomSnackbar(
        "Exito",
        "¡Producto añadido exitosamente!",
        type: CustomSnackbarType.success,
      );
    } catch (e) {
      getCustomSnackbar(
        "Error al Crear Producto",
        "Uy parece que hubo un error al crear un nuevo producto, por favor intenta de nuevo.",
        type: CustomSnackbarType.error,
      );
    }
    loading = false;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
          appBar: WidgetAppBarBack(actionButtonBack: () {
            Get.back();
          }).build(context),
          body: Form(
            key: _formKey,
            child: Container(
              color: Color.fromRGBO(244, 244, 244, 1),
              child: ListView(
                key: Key("addproducLv"),
                padding: EdgeInsets.all(20),
                children: [
                  Column(
                    children: [
                      Container(
                          padding: EdgeInsets.only(top: 20, bottom: 20),
                          child: WidgetAlignText(
                              text: "Nuevo Producto", size: 26)),
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                              padding: EdgeInsets.only(bottom: 10),
                              child: WidgetAlignText(
                                  text: "Datos del producto", size: 18)),
                          WidgetTextField(
                            keyText: Key("nameTf"),
                            label: "Nombre",
                            controller: name,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Por favor ingrese el nombre del producto";
                              }
                            },
                            obscure: false,
                            digitsOnly: false,
                          ),
                          WidgetTextField(
                            keyText: Key("priceTf"),
                            label: "Precio",
                            controller: price,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Por favor ingrese el precio del producto";
                              }
                            },
                            obscure: false,
                            digitsOnly: true,
                          ),
                          WidgetTextField(
                            keyText: Key(""),
                            label: "Cantidad Disponible",
                            controller: amountAvalaible,
                            validator: (value) {
                              if (value!.isEmpty) {
                                if (int.parse(value) == 0) {
                                  return "Por favor ingrese una cantidad valida";
                                }
                              }
                            },
                            obscure: false,
                            digitsOnly: true,
                          ),
                          WidgetTextField(
                            keyText: Key("urlTf"),
                            label: "URL Imagen",
                            controller: urlImage,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Por favor ingrese la url del producto";
                              }
                            },
                            obscure: false,
                            digitsOnly: false,
                          ),
                          WidgetTextField(
                            keyText: Key("descriptionTf"),
                            label: "Descripción",
                            controller: description,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Por favor ingrese una breve descripcion";
                              }
                            },
                            obscure: false,
                            digitsOnly: false,
                            maxLine: 5,
                          ),
                          Row(
                            children: [
                              Container(
                                margin: EdgeInsets.only(left: 25),
                                child: Text(
                                  "Categoria: ",
                                  style: TextStyle(
                                      fontSize: 18,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                dropDown(
                                    key: Key("categoryDb"),
                                    icon: Icon(Icons.arrow_drop_down),
                                    initValue: dropdownValue,
                                    items: categorias),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Container(
                        margin: EdgeInsets.only(top: 10),
                        child: Row(
                          children: [
                            WidgetButton(
                              loading: loading,
                              keyButton: Key("addproductBtn"),
                              text: "Añadir Producto",
                              onPressed: handlerAddProduct,
                              typeMain: true,
                            ),
                          ],
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          )),
    );
  }

  Widget dropDown({initValue, List<String> items = const [], icon, key}) {
    return Expanded(
      child: Container(
        margin: EdgeInsets.only(left: 10, right: 10),
        padding: EdgeInsets.only(left: 10, right: 10),
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(30.0),
            border: Border.all(
              color: Colors.grey,
              width: 1.0,
            )),
        child: ObxValue(
          (data) => DropdownButton(
            iconSize: 50,
            isExpanded: true,
            key: key,
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
      ),
    );
  }
}
