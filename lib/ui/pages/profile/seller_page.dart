import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/ui/pages/product/products_on_sale.dart';
import 'package:xytek/ui/pages/product/sold_products.dart';
import 'package:xytek/ui/pages/profile/reputation_page.dart';
import 'package:xytek/ui/pages/profile/shopper_page.dart';
import 'package:xytek/ui/pages/updateuserdata/my_data_page.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_profile_button.dart';
import 'package:xytek/ui/widgets/widget_rounded_image.dart';

class Seller extends StatelessWidget {
  Seller({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
      appBar: WidgetAppBarBack(actionButtonBack: () {
        Get.back();
      }).build(context),
      body: Container(
        padding: EdgeInsets.all(0),
        color: Color.fromRGBO(244, 244, 244, 1),
        child: ListView(
          children: [
            SizedBox(
              height: media.height - 130,
              child: Column(
                children: [
                  Expanded(
                    flex: 3,
                    child: WidgetRoundedImage(
                      image: 'https://googleflutter.com/sample_image.jpg',
                    ),
                  ),
                  Expanded(
                      flex: 2,
                      child: Column(
                        children: [
                          Text("Jhon Doe",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                          Text("Vendedor",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w300)),
                          TextButton(
                              onPressed: () => {Get.to(() => Reputation())},
                              child: Container(
                                margin: EdgeInsets.only(top: 2),
                                child: RatingBar(
                                  ignoreGestures: true,
                                  updateOnDrag: false,
                                  itemCount: 5,
                                  allowHalfRating: false,
                                  initialRating: 3,
                                  onRatingUpdate: (double value) {},
                                  ratingWidget: RatingWidget(
                                      full:
                                          Icon(Icons.star, color: Colors.amber),
                                      half: Icon(
                                        Icons.star_border,
                                        color: Colors.white,
                                      ),
                                      empty: Icon(Icons.star_border,
                                          color: Colors.amber)),
                                ),
                              ))
                        ],
                      )),
                  Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          WidgetProfileButton(
                            text: "Mis Ventas",
                            onPressed: () {
                              Get.to(() => SoldProducts());
                            },
                          ),
                          WidgetProfileButton(
                            text: "Mis Datos",
                            onPressed: () {
                              Get.to(() => MyData());
                            },
                          ),
                          WidgetProfileButton(
                            text: "Productos en Venta",
                            onPressed: () {
                              Get.to(() => ProductsOnSale());
                            },
                          )
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          children: [
                            WidgetButton(
                                text: "Cerrar Sesión",
                                onPressed: () {},
                                typeMain: false),
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 30),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {
                              Get.to(() => Shopper());
                            },
                            child: Text("Volver a Comprador",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    color: Color.fromRGBO(51, 51, 51, 1))),
                          ),
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
