import 'package:flutter/material.dart';
import 'package:xytek/data/models/product_model.dart';
import 'package:xytek/domain/controllers/authentication/storage_controller.dart';
import 'package:xytek/ui/pages/cart.dart';
import 'package:xytek/ui/pages/product/product_details.dart';
import 'package:xytek/ui/widgets/category_chip.dart';
import 'package:xytek/ui/widgets/custom_drawer.dart';
import 'package:xytek/ui/widgets/product_card.dart';
import 'package:get/get.dart';
import 'package:xytek/ui/widgets/widget_text_align.dart';

class Main extends StatelessWidget {
  Main() {
    storageController = Get.find();
    getProducts();
  }

  late StorageController storageController;

  final List<String> categories = ProductModel.getCategorias().obs;

  var products = [].obs;

  var isSearchingObs = false.obs;

  getProducts() async {
    await storageController.getallProducts();
    products.value = [];
    if (storageController.mainProductsModels.isNotEmpty) {
      for (ProductModel product in storageController.mainProductsModels) {
        products.add(product.toMap());
      }
    }
  }

  bool get isSearching => isSearchingObs.value;
  set isSearching(bool value) => isSearchingObs.value = value;

  @override
  Widget build(BuildContext context) {
    return Obx(() {

      return Scaffold(
        backgroundColor: Colors.grey[100],
        appBar: AppBar(
          title: isSearching
              ? TextField(
                  autofocus: true,
                  cursorColor: Colors.white,
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                    border: InputBorder.none,
                    hintText: "Buscar productos",
                    hintStyle: TextStyle(color: Colors.white70, fontSize: 18),
                  ),
                )
              : Text("Lista de productos"),
          actions: [
            isSearching
                ? IconButton(
                    onPressed: () {
                      isSearching = !isSearching;
                    },
                    icon: Icon(Icons.cancel),
                  )
                : IconButton(
                    onPressed: () {
                      isSearching = !isSearching;
                    },
                    icon: Icon(Icons.search),
                  ),
            IconButton(
                onPressed: () => {Get.to(() => Cart())},
                icon: Icon(Icons.shopping_cart_outlined))
          ],
        ),
        drawer: CustomDrawer(),
        body: Column(
          children: [
            Expanded(
              flex: 4,
              child: Align(
                alignment: Alignment.center,
                child: Text("Slider", style: TextStyle(fontSize: 25)),
              ),
            ),
            WidgetAlignText(text: "Categorias Destacadas", size: 18),
            Expanded(
              flex: 1,
              child: ListView.separated(
                padding: EdgeInsets.symmetric(horizontal: 12),
                scrollDirection: Axis.horizontal,
                itemCount: categories.length,
                separatorBuilder: (context, index) => SizedBox(width: 8),
                itemBuilder: (context, index) {
                  return CategoryChip(
                    key: Key(categories[index]),
                    label: categories[index],
                    onPressed: () {},
                  );
                },
              ),
            ),
            WidgetAlignText(text: "Productos mas vendidos", size: 18),
            Expanded(
              flex: 9,
              child: ListView.builder(
                padding: EdgeInsets.only(right: 8, left: 8, bottom: 8, top: 0),
                itemCount: products.length,
                itemBuilder: (context, index) {
                  return ProductCard(
                    keyButton: Key(products[index]["id"]),
                    onPressed: () {
                      Get.to(() => DetailsProduct(),arguments: [products[index]]);
                    },
                    name: products[index]["name"],
                    image: products[index]["urlImage"],
                    price: products[index]["price"],
                  );
                },
              ),
            )
          ],
        ),
      );
    });
  }
}
