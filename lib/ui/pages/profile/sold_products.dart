import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/data/models/product_model.dart';
import 'package:xytek/data/models/purchase_model.dart';
import 'package:xytek/data/models/user_model.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/domain/controllers/authentication/storage_controller.dart';
import 'package:xytek/ui/pages/profile/purchase_details.dart';
import 'package:xytek/ui/widgets/category_chip.dart';
import 'package:xytek/ui/widgets/product_card.dart';

import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_text_align.dart';

// ignore: must_be_immutable
class SoldProducts extends StatelessWidget {
  SoldProducts({Key? key}) : super(key: key) {
    storageController = Get.find();
    auth = Get.find();
    getProducts();
  }

  final List<String> categories = ProductModel.getCategorias().obs;
  late StorageController storageController;
  late AuthController auth;
  var products = [].obs;

  getProducts({category = ""}) async {
    products.value = await storageController.getPurchases(
        sellerId: auth.userIDLogged, isShopper: false, category: category);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBarBack(actionButtonBack: () {
        Get.back();
      }).build(context),
      body: Container(
        color: Color.fromRGBO(244, 244, 244, 1),
        child: Column(
          children: [
            WidgetAlignText(text: "Mis Ventas", size: 20),
            Container(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: WidgetAlignText(text: "Categorias", size: 18)),
            Expanded(
              flex: 1,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 12),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (context, index) => SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return CategoryChip(
                    categoryKey: Key(categories[index]),
                    label: categories[index],
                    onPressed: () async {
                      if (categories[index] == "Todas") {
                        await getProducts();
                      } else {
                        await getProducts(category: categories[index]);
                      }
                    },
                  );
                },
              ),
            ),
            Expanded(
                flex: 9,
                // ignore: invalid_use_of_protected_member
                child: Obx(() => products.value.isEmpty
                    ? Center(child: Text("No tiene productos vendidos"))
                    : ListView.builder(
                        padding: EdgeInsets.only(
                            right: 8, left: 8, bottom: 8, top: 0),
                        itemCount: products.length,
                        itemBuilder: (context, index) {
                          ProductModel product = products[index]["product"];
                          PurchaseModel purchase = products[index]["purchase"];
                          UserModel shopper = products[index]["shopper"];
                          return ProductCard(
                            keyButton: Key(purchase.id),
                            onPressed: () {
                              Get.to(() => PurchaseDetails(),
                                  arguments: [purchase, product, shopper]);
                            },
                            name: product.name,
                            image: product.urlImage,
                            price: product.price * purchase.quantity,
                          );
                        },
                      )))
          ],
        ),
      ),
    );
  }
}
