import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/domain/controllers/authentication/storage_controller.dart';
import 'package:xytek/ui/widgets/cart_item.dart';
import 'package:xytek/ui/widgets/custom_snackbar.dart';

import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_button.dart';

// ignore: must_be_immutable
class PaymentPage extends StatelessWidget {
  PaymentPage({Key? key}) : super(key: key) {
    storageController = Get.find();
    auth = Get.find();
  }
  late AuthController auth;

  late StorageController storageController;

  var dropdownValue = "Mi casa".obs;
  List<String> direcciones = ["Mi casa", "Trabajo", "Tienda"];

  var dropdownValuePay = "PSE".obs;
  List<String> methods = ["PSE", "Tarjeta debito", "Efectivo"];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBarBack(actionButtonBack: () {
        Get.back();
      }).build(context),
      body: SingleChildScrollView(
        child: Container(
          margin: EdgeInsets.only(right: 20, left: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Tu pedido",
                overflow: TextOverflow.ellipsis,
                maxLines: 5,
                style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
              ),
              Container(
                margin: EdgeInsets.only(top: 10),
                child: Text(
                  "Dirección de entrega",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 10, left: 10),
                child: dropDown(
                    icon: Icon(Icons.arrow_drop_down),
                    initValue: dropdownValue,
                    items: direcciones),
              ),
              Container(
                margin: EdgeInsets.only(bottom: 20, top: 10),
                child: Text(
                  "Productos:",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.grey.withOpacity(0.5),
                            style: BorderStyle.solid),
                        left: BorderSide(
                            color: Colors.grey.withOpacity(0.5),
                            style: BorderStyle.solid),
                        right: BorderSide(
                            color: Colors.grey.withOpacity(0.5),
                            style: BorderStyle.solid),
                        top: BorderSide(
                            color: Colors.grey.withOpacity(0.5),
                            style: BorderStyle.solid))),
                child: SizedBox(
                  height: 300,
                  child: ListView(
                    children: [
                      ...storageController.cartProductsModels.map((product) {
                        return CartItem(
                          id: product['id'],
                          name: product["name"],
                          image: product["urlImage"],
                          price: product["price"],
                          quantity: product["quantity"],
                          onAdd: () {},
                          onRemove: () {},
                          withButtons: false,
                        );
                      }).toList()
                    ],
                  ),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    border: Border(
                        bottom: BorderSide(
                            color: Colors.grey.withOpacity(0.5),
                            style: BorderStyle.solid),
                        left: BorderSide(
                            color: Colors.grey.withOpacity(0.5),
                            style: BorderStyle.solid),
                        right: BorderSide(
                            color: Colors.grey.withOpacity(0.5),
                            style: BorderStyle.solid),
                        top: BorderSide(
                            color: Colors.grey.withOpacity(0.5),
                            style: BorderStyle.solid))),
                child: Row(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          margin: EdgeInsets.only(left: 10, bottom: 20),
                          child: Text(
                            "Entrega estimada",
                            style: TextStyle(
                              fontSize: 15,
                            ),
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(left: 10, bottom: 20),
                          child: Text(
                            "2 días",
                            style: TextStyle(fontSize: 12),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: Text(
                  "Metodo de pago",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              Container(
                margin: EdgeInsets.only(top: 20),
                child: dropDown(
                    icon: Icon(Icons.arrow_drop_down),
                    initValue: dropdownValuePay,
                    items: methods),
              ),
              Row(
                children: [
                  WidgetButton(
                      keyButton: Key("payLastBtn"),
                      text: "Pagar",
                      onPressed: () async {
                        try {
                          await storageController.addPurchase(
                              payment: dropdownValuePay.value,
                              shopperId: auth.userIDLogged);
                          storageController.cartProductsModels.value = [];
                          Get.offNamed("/");
                          getCustomSnackbar(
                            "Pedido Exitoso",
                            "Pedido realizado con exito.",
                            type: CustomSnackbarType.success,
                          );
                        } catch (e) {
                          getCustomSnackbar(
                            "Error",
                            "Error al crear pedido, revise los datos o la conexion a internet.",
                            type: CustomSnackbarType.error,
                          );
                        }
                      },
                      typeMain: true),
                ],
              )
            ],
          ),
        ),
      ),
    );
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
