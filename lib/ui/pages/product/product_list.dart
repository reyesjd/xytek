import 'package:flutter/material.dart';
import 'package:xytek/data/models/product_model.dart';
import 'package:xytek/ui/pages/product/product_details.dart';
import 'package:xytek/ui/widgets/category_chip.dart';
import 'package:xytek/ui/widgets/custom_drawer.dart';
import 'package:xytek/ui/widgets/product_card.dart';
import 'package:get/get.dart';

class ProductList extends StatelessWidget {
  final List<String> categories = ProductModel.getCategorias().obs;

  final List<Map> products = [
    {
      "id": "1",
      "name": "Tarjeta de video Nvidia Gigabyte",
      "image":
          'https://http2.mlstatic.com/D_NQ_NP_831583-MCO40904870588_022020-O.webp',
      "price": 350000,
    },
    {
      "id": "2",
      "name": "Tarjeta de video Nvidia Gigabyte",
      "image":
          'https://http2.mlstatic.com/D_NQ_NP_831583-MCO40904870588_022020-O.webp',
      "price": 350000,
    },
    {
      "id": "3",
      "name": "Tarjeta de video Nvidia Gigabyte",
      "image":
          'https://http2.mlstatic.com/D_NQ_NP_831583-MCO40904870588_022020-O.webp',
      "price": 350000,
    },
    {
      "id": "4",
      "name": "Tarjeta de video Nvidia Gigabyte",
      "image":
          'https://http2.mlstatic.com/D_NQ_NP_831583-MCO40904870588_022020-O.webp',
      "price": 350000,
    },
    {
      "id": "5",
      "name": "Tarjeta de video Nvidia Gigabyte",
      "image":
          'https://http2.mlstatic.com/D_NQ_NP_831583-MCO40904870588_022020-O.webp',
      "price": 350000,
    },
    {
      "id": "6",
      "name": "Tarjeta de video Nvidia Gigabyte",
      "image":
          'https://http2.mlstatic.com/D_NQ_NP_831583-MCO40904870588_022020-O.webp',
      "price": 350000,
    },
    {
      "id": "7",
      "name": "Tarjeta de video Nvidia Gigabyte",
      "image":
          'https://http2.mlstatic.com/D_NQ_NP_831583-MCO40904870588_022020-O.webp',
      "price": 350000,
    },
    {
      "id": "8",
      "name": "Tarjeta de video Nvidia Gigabyte",
      "image":
          'https://http2.mlstatic.com/D_NQ_NP_831583-MCO40904870588_022020-O.webp',
      "price": 350000,
    },
    {
      "id": "9",
      "name": "Tarjeta de video Nvidia Gigabyte",
      "image":
          'https://http2.mlstatic.com/D_NQ_NP_831583-MCO40904870588_022020-O.webp',
      "price": 350000,
    },
    {
      "id": "10",
      "name": "Tarjeta de video Nvidia Gigabyte",
      "image":
          'https://http2.mlstatic.com/D_NQ_NP_831583-MCO40904870588_022020-O.webp',
      "price": 350000,
    },
    {
      "id": "11",
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
                        key: Key("searchTf"),
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
                      separatorBuilder: (context, index) => SizedBox(width: 8),
                      itemBuilder: (context, index) {
                        return CategoryChip(
                          categoryKey: Key(categories[index]),
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
                          keyButton: Key(products[index]["id"]),
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
