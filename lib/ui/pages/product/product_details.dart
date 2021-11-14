import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:xytek/ui/pages/product/add_comment.dart';
import 'package:xytek/ui/widgets/listile_comment_product.dart';
import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_rounded_image.dart';
import 'package:xytek/ui/widgets/widget_text_align.dart';

// ignore: must_be_immutable
class DetailsProduct extends StatelessWidget {
  DetailsProduct({Key? key}) : super(key: key);

  var product = Get.arguments[0];

  String amount = "10";

  String description =
      "Esto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensa";
  //Hay que pedir la informacion desde la clase userModel o userSaler el vendedor
  String nameSaler = "Nombre del vendedor";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {},
          child: Icon(Icons.add_shopping_cart_rounded),
        ),
        appBar: WidgetAppBarBack(actionButtonBack: () {
          Get.back();
        }).build(context),
        body: Container(
          padding: EdgeInsets.all(20),
          color: Color.fromRGBO(244, 244, 244, 1),
          child: ListView(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Center(
                          child: Column(
                            children: [
                              WidgetRoundedImage(image: product["urlImage"]),
                              Container(
                                padding: EdgeInsets.only(top: 10, bottom: 5),
                                child: Center(
                                  child: Text(product["name"],
                                      style: TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold)),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Text(
                          product["category"],
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          "${product["price"]}",
                          style: TextStyle(fontSize: 15),
                        ),
                        Text(
                          int.parse(amount) > 0
                              ? "$amount disponibles"
                              : "no disponible",
                          style: TextStyle(fontSize: 15),
                        ),
                      ],
                    ),
                    Container(
                      padding: EdgeInsets.only(top: 10),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          WidgetAlignText(
                              text: "Datalles del producto:", size: 18),
                          Container(
                            padding:
                                EdgeInsets.only(left: 20, top: 10, bottom: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Text(
                                product["description"],
                                style: TextStyle(fontSize: 15),
                              ),
                            ),
                          ),
                          Row(
                            children: [
                              WidgetButton(
                                  text: "Añadir comentario",
                                  onPressed: () {
                                    Get.to(() => AddComment(onPressed: (commet, ) {

                                    }));
                                  },
                                  typeMain: false),
                            ],
                          ),
                          Container(
                              padding: EdgeInsets.only(top: 20, bottom: 10),
                              child: WidgetAlignText(
                                  text: "Calificación del vendedor:",
                                  size: 18)),
                          Container(
                              padding: EdgeInsets.only(top: 20, bottom: 10),
                              child: WidgetAlignText(
                                  text: "Calificación del producto:",
                                  size: 18)),
                          Column(
                            children: [
                              WidgetCommentProduct(
                                  linkImage:
                                      "https://i0.wp.com/tualquiler.cr/wp-content/uploads/2017/03/default-user.png?ssl=1",
                                  comment: "este es mi comentario",
                                  date: "20/12/2021",
                                  name: "manuel",
                                  rating: 3.2)
                            ],
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
