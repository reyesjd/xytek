import 'package:flutter/material.dart';
import 'package:xytek/ui/pages/product/product_details.dart';
import 'package:xytek/ui/widgets/category_chip.dart';
import 'package:xytek/ui/widgets/custom_drawer.dart';
import 'package:xytek/ui/widgets/product_card.dart';
import 'package:get/get.dart';

class ProductList extends StatelessWidget {
  final List<Map> categories = [
    {"label": "Categoría 1"},
    {"label": "Categoría 2"},
    {"label": "Categoría 3"},
    {"label": "Categoría 4"},
    {"label": "Categoría 5"},
  ];

  final List<Map> products = [
    {
      "name": "Tarjeta de video Nvidia Gigabyte",
      "image":
          'https://http2.mlstatic.com/D_NQ_NP_831583-MCO40904870588_022020-O.webp',
      "price": 350000,
    },
    {
      "name": "Tarjeta de video Nvidia Gigabyte",
      "image":
          'https://http2.mlstatic.com/D_NQ_NP_831583-MCO40904870588_022020-O.webp',
      "price": 350000,
    },
    {
      "name": "Tarjeta de video Nvidia Gigabyte",
      "image":
          'https://http2.mlstatic.com/D_NQ_NP_831583-MCO40904870588_022020-O.webp',
      "price": 350000,
    },
    {
      "name": "Tarjeta de video Nvidia Gigabyte",
      "image":
          'https://http2.mlstatic.com/D_NQ_NP_831583-MCO40904870588_022020-O.webp',
      "price": 350000,
    },
    {
      "name": "Tarjeta de video Nvidia Gigabyte",
      "image":
          'https://http2.mlstatic.com/D_NQ_NP_831583-MCO40904870588_022020-O.webp',
      "price": 350000,
    },
    {
      "name": "Tarjeta de video Nvidia Gigabyte",
      "image":
          'https://http2.mlstatic.com/D_NQ_NP_831583-MCO40904870588_022020-O.webp',
      "price": 350000,
    },
    {
      "name": "Tarjeta de video Nvidia Gigabyte",
      "image":
          'https://http2.mlstatic.com/D_NQ_NP_831583-MCO40904870588_022020-O.webp',
      "price": 350000,
    },
    {
      "name": "Tarjeta de video Nvidia Gigabyte",
      "image":
          'https://http2.mlstatic.com/D_NQ_NP_831583-MCO40904870588_022020-O.webp',
      "price": 350000,
    },
    {
      "name": "Tarjeta de video Nvidia Gigabyte",
      "image":
          'https://http2.mlstatic.com/D_NQ_NP_831583-MCO40904870588_022020-O.webp',
      "price": 350000,
    },
    {
      "name": "Tarjeta de video Nvidia Gigabyte",
      "image":
          'https://http2.mlstatic.com/D_NQ_NP_831583-MCO40904870588_022020-O.webp',
      "price": 350000,
    },
    {
      "name": "Tarjeta de video Nvidia Gigabyte",
      "image":
          'https://http2.mlstatic.com/D_NQ_NP_831583-MCO40904870588_022020-O.webp',
      "price": 350000,
    },
  ];

  final isSearchingObs = false.obs;

  bool get isSearching => isSearchingObs.value;
  set isSearching(bool value) => isSearchingObs.value = value;

  @override
  Widget build(BuildContext context) {
    return ObxValue(
        (data) => Scaffold(
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
                          hintStyle:
                              TextStyle(color: Colors.white70, fontSize: 18),
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
                ],
              ),
              drawer: CustomDrawer(),
              body: Column(
                children: [
                  Expanded(
                    flex: 1,
                    child: ListView.separated(
                      padding: EdgeInsets.symmetric(horizontal: 12),
                      scrollDirection: Axis.horizontal,
                      itemCount: categories.length,
                      separatorBuilder: (context, index) => SizedBox(
                        width: 8,
                        height: 8,
                      ),
                      itemBuilder: (context, index) {
                        return CategoryChip(
                          label: categories[index]["label"],
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
                            Get.to(() => DetailsProduct());
                          },
                          name: products[index]["name"],
                          image: products[index]["image"],
                          price: products[index]["price"],
                        );
                      },
                    ),
                  )
                ],
              ),
            ),
        isSearchingObs);
  }
}
