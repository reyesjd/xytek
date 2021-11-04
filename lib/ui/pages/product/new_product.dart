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
class NewProduct extends StatelessWidget {
  NewProduct({Key? key}) : super(key: key);

  final TextEditingController name = TextEditingController();
  final TextEditingController price = TextEditingController();
  final TextEditingController description = TextEditingController();
  final TextEditingController urlImage = TextEditingController();
  final StorageController storageController = Get.find();
  final AuthController authController = Get.find();

  final _formKey = GlobalKey<FormState>();
  var dropdownValue = "Placas Base".obs;
  List<String> categorias = ProductModel.getCategorias();

  void handlerAddProduct() async {
    try {
      var user = authController.userModelLogged;
      await storageController.addNewProduct(
          name: name.text,
          category: dropdownValue.value,
          description: description.text,
          price: int.parse(price.text),
          urlImage: urlImage.text,
          user:user );
      
      Get.back();
      Get.snackbar("Exito", "¡Producto añadido exitosamente!",
          backgroundColor: Colors.green);
    } catch (e) {
      Get.snackbar("Error al Crear Producto",
          "Uy parece que hubo un error al crear un nuevo producto, por favor intenta de nuevo.",
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
              children: [
                SizedBox(
                  height: media.height - 130,
                  child: Column(
                    children: [
                      WidgetAlignText(text: "Nuevo Producto", size: 26),
                      Expanded(
                        flex: 2,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            WidgetAlignText(
                                text: "Datos del producto", size: 18),
                            WidgetTextField(
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
                                icon: Icon(Icons.arrow_drop_down),
                                initValue: dropdownValue,
                                items: categorias),
                            WidgetTextField(
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
                              text: "Añadir Producto",
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
