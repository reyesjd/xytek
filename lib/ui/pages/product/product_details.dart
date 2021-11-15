import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:get/get.dart';
import 'package:xytek/data/models/product_model.dart';
import 'package:xytek/data/models/rating_product_model.dart';
import 'package:xytek/data/models/rating_user_model.dart';
import 'package:xytek/data/models/user_model.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/domain/controllers/authentication/storage_controller.dart';
import 'package:xytek/ui/pages/product/add_comment.dart';
import 'package:xytek/ui/pages/profile/seller_profile.dart';
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

  AuthController auth = Get.find();
  StorageController storage = Get.find();
  late UserModel? sellerUser;

  DetailsProduct({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: SizedBox(
          height: 70,
          width: 70,
          child: FloatingActionButton(
            onPressed: () {
              List verf = storage.cartProductsModels
                  .where((productL) => productL["id"] == product["id"])
                  .toList();
              if (verf.isEmpty) {
                if (product["amountAvalaible"] > 0) {
                  product.addAll(<String, dynamic>{'quantity': RxInt(1)});
                  storage.cartProductsModels.add(product);
                  Get.snackbar("Producto Añadido",
                      "El producto se ha agregado al carrito",
                      backgroundColor: Colors.green);
                } else {
                  Get.snackbar("Producto no disponible",
                      "No se encuentran productos disponibles",
                      backgroundColor: Colors.red);
                }
              } else {
                Get.snackbar("Producto en carrito",
                    "El producto que intentas agregar ya se encuentra en el carrito",
                    backgroundColor: Colors.red);
              }
            },
            child: Icon(
              Icons.add_shopping_cart_rounded,
              size: 40,
            ),
            isExtended: true,
          ),
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
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Text(
                      product["category"],
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 5),
                    child: Text(
                      formatCurrency
                          .format(product["price"])
                          .replaceAll(',', '.'),
                      style: TextStyle(fontSize: 15),
                    ),
                  ),
                  Text(
                    product["amountAvalaible"] > 0
                        ? "${product["amountAvalaible"]} disponibles"
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
                    FutureBuilder(
                      builder: (context, snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          List list = snapshot.data as List;
                          UserModel? user = list[0];
                          List<RatingUserModel> listRating = list[1];
                          if (user != null) {
                            return listTile(
                                linkImage: "",
                                name: user.name,
                                rating: getAverageSellerRating(listRating),
                                seller: user,
                                listRatings: listRating);
                          } else {
                            return Container(
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
                              child: Text(
                                  "No ha sido posible cargar la informacion del vendedor"),
                            );
                          }
                        } else {
                          if (snapshot.hasError) {
                            return Container(
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
                              child: Text(
                                  "No ha sido posible cargar la informacion del vendedor"),
                            );
                          } else {
                            return Container(
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
                                child:
                                    Center(child: CircularProgressIndicator()));
                          }
                        }
                      },
                      future: getInfoSellerAndRating(),
                    ),
                    auth.userIDLogged.isNotEmpty
                        ? Container(
                            margin: EdgeInsets.only(top: 10),
                            child: Row(
                              children: [
                                WidgetButton(
                                    text: " Comentar Producto",
                                    onPressed: () {
                                      Get.to(() => AddComment(), arguments: [
                                        ProductModel.fromMap(product),
                                        true
                                      ]);
                                    },
                                    typeMain: false),
                              ],
                            ),
                          )
                        : Container(),
                    Container(
                        padding: EdgeInsets.only(top: 20, bottom: 10),
                        child: WidgetAlignText(
                            text: "Calificación del producto:", size: 18)),
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
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget listTile({linkImage, name, rating, seller, listRatings}) {
    return GestureDetector(
      onTap: () {
        Get.to(() => SellerProfile(), arguments: [seller, listRatings]);
      },
      child: Container(
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
        child: ListTile(
          leading: WidgetRoundedImage(
            image: linkImage,
            small: true,
          ),
          title: Text(name),
          subtitle: Container(
              margin: EdgeInsets.only(top: 2),
              child: RatingBar(
                itemSize: 25,
                ignoreGestures: true,
                updateOnDrag: false,
                itemCount: 5,
                allowHalfRating: true,
                initialRating: rating,
                onRatingUpdate: (double value) {},
                ratingWidget: RatingWidget(
                    full: Icon(Icons.star, color: Colors.amber),
                    half: Icon(Icons.star_half, color: Colors.amber),
                    empty: Icon(Icons.star_border, color: Colors.amber)),
              )),
        ),
      ),
    );
  }

  Future<List> getInfoSellerAndRating() async {
    UserModel? user = await storage.getUserById(product["uid"]);
    List<RatingUserModel> list = await storage.getUserRatings(product["uid"]);
    return [user, list];
  }

  double getAverageSellerRating(List<RatingUserModel> list) {
    print("Listaskabshxvasjdvsax");
    print(list);
    if (list.isEmpty) {
      return 3.2;
    } else {
      double sum = 0;
      for (RatingUserModel rating in list) {
        sum = sum + rating.rating;
      }
      return sum / list.length;
    }
  }
}
