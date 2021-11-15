import 'package:flutter/material.dart';
import 'package:xytek/data/models/product_model.dart';
import 'package:xytek/domain/controllers/authentication/storage_controller.dart';
import 'package:xytek/ui/widgets/cart_item.dart';
import 'package:get/get.dart';
import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:intl/intl.dart';
import 'package:xytek/ui/widgets/widget_button.dart';

class Cart extends StatelessWidget {
  Cart() {
    storageController = Get.find();
  }

  late StorageController storageController;

  final formatCurrency = NumberFormat.currency(
    decimalDigits: 0,
    symbol: '\$',
    customPattern: '\u00a4 ###,###',
  );

  int getTotal() {
    int total = 0;
    for (var p in storageController.cartProductsModels) {
      total += (p['price'] * p['quantity'].value) as int;
    }
    return total;
  }

  @override
  Widget build(BuildContext context) {
    return Obx(
      () => Scaffold(
        appBar: WidgetAppBarBack(
                actionButtonBack: () {
                  Get.back();
                },
                title: "Carrito")
            .build(context),
        body: Column(
          children: [
            Expanded(
              flex: 1,
              child: storageController.cartProductsModels.isNotEmpty
                  ? Container(
                      margin: EdgeInsets.all(15),
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
                      child: ListView(
                        children: [
                          ...storageController.cartProductsModels
                              .map((product) {
                            return CartItem(
                              id: product['id'],
                              name: product["name"],
                              image: product["urlImage"],
                              price: product["price"],
                              quantity: product["quantity"],
                              onAdd: () {
                                var p = storageController.cartProductsModels
                                    .firstWhere(
                                        (p) => p['id'] == product['id']);
                                if (p['quantity'].value <
                                    p["amountAvalaible"]) {
                                  p['quantity'].value += 1;
                                }
                              },
                              onRemove: () {
                                var p = storageController.cartProductsModels
                                    .firstWhere(
                                        (p) => p['id'] == product['id']);
                                if (p['quantity'].value > 1) {
                                  p['quantity'].value -= 1;
                                } else {
                                  storageController.cartProductsModels
                                      .removeWhere((element) =>
                                          element['id'] == product['id']);
                                }
                              },
                            );
                          }).toList(),
                        ],
                      ),
                    )
                  : Container(
                      margin: EdgeInsets.all(15),
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
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Tu carrito está vacío",
                                style: TextStyle(fontSize: 20),
                              ),
                              Icon(
                                Icons.shopping_cart_rounded,
                                size: 100,
                                color: Colors.grey,
                              )
                            ],
                          ),
                        ],
                      ),
                    ),
            ),
            if (storageController.cartProductsModels.isNotEmpty)
              Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Container(
                        margin: EdgeInsets.only(top: 20),
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          "Total ${formatCurrency.format(getTotal()).replaceAll(',', '.')}",
                          style: TextStyle(fontSize: 20),
                        ),
                      )
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 10, top: 10),
                    child: Row(
                      children: [
                        WidgetButton(
                            text: "Pagar", onPressed: () {}, typeMain: true),
                      ],
                    ),
                  )
                ],
              )
          ],
        ),
      ),
    );
  }
}
