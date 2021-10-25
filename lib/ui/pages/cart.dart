import 'package:flutter/material.dart';
import 'package:xytek/ui/widgets/cart_item.dart';
import 'package:get/get.dart';
import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:intl/intl.dart';

class Cart extends StatelessWidget {
  final List<Map> products = [
    {
      "id": 1,
      "name": "Tarjeta de video Nvidia Gigabyte",
      "image":
          'https://http2.mlstatic.com/D_NQ_NP_831583-MCO40904870588_022020-O.webp',
      "price": 350000,
      "quantity": 1.obs
    },
    {
      "id": 2,
      "name": "Tarjeta de video Nvidia Gigabyte",
      "image":
          'https://http2.mlstatic.com/D_NQ_NP_831583-MCO40904870588_022020-O.webp',
      "price": 350000,
      "quantity": 3.obs
    },
  ].obs;

  final formatCurrency = NumberFormat.currency(
    decimalDigits: 0,
    symbol: '\$',
    customPattern: '\u00a4 ###,###',
  );

  int getTotal() {
    int total = 0;
    for (var p in products) {
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
            ...products.map((product) {
              return Padding(
                padding: EdgeInsets.symmetric(horizontal: 8),
                child: CartItem(
                  id: product['id'],
                  name: product["name"],
                  image: product["image"],
                  price: product["price"],
                  quantity: product["quantity"],
                  onAdd: () {
                    for (var p in products) {
                      if (p['id'] == product['id']) {
                        p['quantity'].value += 1;
                      }
                    }
                  },
                  onRemove: () {
                    for (var p in products) {
                      if (p['id'] == product['id']) {
                        if (p['quantity'].value > 1) {
                          p['quantity'].value -= 1;
                        }
                      }
                    }
                  },
                ),
              );
            }).toList(),
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
            )
          ],
        ),
      ),
    );
  }
}
