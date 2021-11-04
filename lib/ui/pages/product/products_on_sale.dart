import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/data/models/product_model.dart';
import 'package:xytek/data/models/user_model.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/domain/controllers/authentication/storage_controller.dart';
import 'package:xytek/ui/pages/product/new_product.dart';
import 'package:xytek/ui/pages/profile/open_sale_details.dart';
import 'package:xytek/ui/widgets/category_chip.dart';
import 'package:xytek/ui/widgets/product_card.dart';

import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_text_align.dart';

// ignore: must_be_immutable
class ProductsOnSale extends StatelessWidget {
  ProductsOnSale({Key? key}) : super(key: key) {
    storageController = Get.find();
    authController = Get.find();
    getSalesProducts();
  }
  late StorageController storageController;
  late AuthController authController;

  final List<String> categories = ProductModel.getCategorias().obs;

  var products = [].obs;

  getSalesProducts() {
    products.value = [];
    if (storageController.salesProductsModels.isNotEmpty) {
      for (ProductModel product in storageController.salesProductsModels) {
        products.add(product.toMap());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetX(builder: (StorageController controller) {
      getSalesProducts();
      return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.add),
          onPressed: () => {Get.to(() => NewProduct())},
          backgroundColor: Color.fromRGBO(42, 157, 143, 1),
        ),
        appBar: WidgetAppBarBack(actionButtonBack: () {
          Get.back();
        }).build(context),
        body: Container(
          padding: EdgeInsets.all(20),
          color: Color.fromRGBO(244, 244, 244, 1),
          child: Column(
            children: [
              WidgetAlignText(text: "Productos en venta", size: 20),
              Expanded(
                flex: 1,
                child: ListView.separated(
                  padding: EdgeInsets.symmetric(horizontal: 12),
                  scrollDirection: Axis.horizontal,
                  itemCount: categories.length,
                  separatorBuilder: (context, index) => SizedBox(width: 8),
                  itemBuilder: (context, index) {
                    return CategoryChip(
                      label: categories[index],
                      onPressed: () {},
                    );
                  },
                ),
              ),
              Expanded(
                  flex: 9,
                  child: ListView.builder(
                    padding:
                        EdgeInsets.only(right: 8, left: 8, bottom: 8, top: 0),
                    itemCount: products.length,
                    itemBuilder: (context, index) {
                      return ProductCard(
                        onPressed: () {
                          Get.to(() => OpenDetailsSale(),
                              arguments: [products[index]]);
                        },
                        name: products[index]["name"],
                        image: products[index]["urlImage"],
                        price: products[index]["price"],
                      );
                    },
                  ))
            ],
          ),
        ),
      );
    });
  }
}
