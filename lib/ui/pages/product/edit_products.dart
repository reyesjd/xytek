import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/data/models/product_model.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/domain/controllers/authentication/storage_controller.dart';

import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_text_align.dart';
import 'package:xytek/ui/widgets/widget_text_field.dart';

// ignore: must_be_immutable
class EditProduct extends StatelessWidget {
  EditProduct({Key? key}) : super(key: key) {
    product = Get.arguments[0];
    initValues();
  }

  late RxMap<String, dynamic> product;

  final TextEditingController name = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController urlImage = TextEditingController();
  final StorageController storageController = Get.find();
  final AuthController authController = Get.find();

  initValues() {
    name.text = product["name"];
    price.text = "${product["price"]}";
    description.text = product["description"];
    urlImage.text = product["urlImage"];
    dropdownValue = RxString(product["category"]);
  }

  setValues() {
    product["name"] = name.text;
    product["price"] = int.parse(price.text);
    product["description"] = description.text;
    product["urlImage"] = urlImage.text;
    product["category"] = dropdownValue.value;
  }

  final _formKey = GlobalKey<FormState>();
  late RxString dropdownValue;
  List<String> categorias = ProductModel.getCategorias();

  void handlerAddProduct() async {
    try {
      String uid = authController.userIDLogged;
      await storageController.updateInfoProduct(
          name: name.text,
          category: dropdownValue.value,
          description: description.text,
          price: int.parse(price.text),
          urlImage: urlImage.text,
          uid: uid,
          id: product["id"]);
      setValues();
      storageController.salesProductsModels
          .removeWhere((element) => element.id == product["id"]);

      storageController.salesProductsModels.add(ProductModel(name: name.text,
          category: dropdownValue.value,
          description: description.text,
          price: int.parse(price.text),
          urlImage: urlImage.text,
          uid: uid,
          id: product["id"]));

      Get.back(result: product);
      Get.snackbar("Exito", "¡Producto actualizado exitosamente!",
          backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar("Error al Crear Producto",
          "Uy parece que hubo un error al actualizar el producto, por favor intenta de nuevo.",
          backgroundColor: Colors.red);
    }
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
              key: Key("editproductLv"),
              children: [
                SizedBox(
                  height: media.height - 130,
                  child: Column(
                    children: [
                      WidgetAlignText(text: "Actualiza tu Producto", size: 26),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            WidgetAlignText(
                                text: "Datos del producto", size: 18),
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
                              keyText: Key("descriptionTf"),
                              label: "Descripcion",
                              controller: description,
                              validator: (value) {
                                if (value!.isEmpty) {
                                  return "Por favor ingrese una breve descripcion";
                                }
                              },
                              obscure: false,
                              digitsOnly: false,
                            ),
                            Row(
                              children: [
                                Container(
                                    margin: EdgeInsets.only(left: 25),
                                    child: Text("Categoria: ",
                                        style: TextStyle(
                                            fontSize: 18,
                                            fontWeight: FontWeight.bold))),
                              ],
                            ),
                            dropDown(
                                key: Key("categoryDb"),
                                icon: Icon(Icons.arrow_drop_down),
                                initValue: dropdownValue,
                                items: categorias),
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
                            )
                          ],
                        ),
                      ),
                      Row(
                        children: [
                          WidgetButton(
                              keyButton: Key("updateproductBtn"),
                              text: "Actualizar Producto",
                              onPressed: handlerAddProduct,
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

  Widget dropDown({initValue, List<String> items = const [], icon, key}) {
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
    );
  }
}
