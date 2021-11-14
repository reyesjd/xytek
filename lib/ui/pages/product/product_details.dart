import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:xytek/data/models/product_model.dart';
import 'package:xytek/data/models/rating_product_model.dart';
import 'package:xytek/data/models/user_model.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/domain/controllers/authentication/storage_controller.dart';
import 'package:xytek/ui/pages/product/add_comment.dart';
import 'package:xytek/ui/widgets/listile_comment_product.dart';
import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_button.dart';

import 'package:xytek/ui/widgets/widget_rounded_image.dart';
import 'package:xytek/ui/widgets/widget_text_align.dart';
import 'package:intl/intl.dart';

// ignore: must_be_immutable
class DetailsProduct extends StatelessWidget {
  var product = Get.arguments[0];

  final formatCurrency = NumberFormat.currency(
    decimalDigits: 0,
    symbol: '\$',
    customPattern: '\u00a4 ###,###',
  );

  String amount = "10";

  AuthController auth = Get.find();
  StorageController storage = Get.find();
  late UserModel? sellerUser;

  DetailsProduct({Key? key}) : super(key: key);

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
                                    fontSize: 20, fontWeight: FontWeight.bold)),
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
                    formatCurrency
                        .format(product["price"])
                        .replaceAll(',', '.'),
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
                    WidgetAlignText(text: "Datalles del producto:", size: 18),
                    Container(
                      padding: EdgeInsets.only(left: 20, top: 10, bottom: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          product["description"],
                          style: TextStyle(fontSize: 15),
                        ),
                      ),
                    ),
                    Container(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: WidgetAlignText(
                            text: "Calificación del vendedor:", size: 18)),
                    Container(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: WidgetAlignText(
                            text: "Calificación del producto:", size: 18)),
                    auth.userIDLogged.isNotEmpty
                        ? Container(
                            alignment: Alignment.center,
                            child: WidgetButton(
                                text: "Calificar producto",
                                onPressed: () {
                                  Get.to(() => AddComment(), arguments: [
                                    ProductModel.fromMap(product)
                                  ]);
                                },
                                typeMain: false),
                          )
                        : Container(),
                    Column(
                      children: [
                        FutureBuilder(
                          builder: (context, snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.done) {
                              List<RatingProductModel> list =
                                  snapshot.data as List<RatingProductModel>;
                              List<Widget> listW =
                                  List.generate(list.length, (index) {
                                return WidgetCommentProduct(
                                    linkImage: list[index].urlImage,
                                    comment: list[index].comment,
                                    date: list[index].date,
                                    name: list[index].name,
                                    rating: list[index].rating);
                              });
                              return Column(
                                children: listW,
                              );
                            } else {
                              if (snapshot.hasError) {
                                return Text(
                                    "No ha sido posible cargar los comentarios");
                              } else {
                                return Center(
                                    child: CircularProgressIndicator());
                              }
                            }
                          },
                          future: storage.getProductsRating(product["id"]),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Future<Widget> listTile({linkImage, name, rating}) async {
    return ListTile(
      leading: WidgetRoundedImage(
        image: linkImage,
        small: true,
      ),
      title: Text(name),
      subtitle: Container(
          margin: EdgeInsets.only(top: 2),
          child: RatingBar(
            ignoreGestures: true,
            updateOnDrag: false,
            itemCount: 5,
            allowHalfRating: false,
            initialRating: rating,
            onRatingUpdate: (double value) {},
            ratingWidget: RatingWidget(
                full: Icon(Icons.star, color: Colors.amber),
                half: Icon(
                  Icons.star_border,
                  color: Colors.white,
                ),
                empty: Icon(Icons.star_border, color: Colors.amber)),
          )),
    );
  }
}
