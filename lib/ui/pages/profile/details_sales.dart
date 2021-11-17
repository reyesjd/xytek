import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xytek/data/models/product_model.dart';
import 'package:xytek/data/models/purchase_model.dart';
import 'package:xytek/data/models/rating_product_model.dart';
import 'package:xytek/data/models/rating_user_model.dart';
import 'package:xytek/data/models/user_model.dart';
import 'package:xytek/domain/controllers/authentication/storage_controller.dart';
import 'package:xytek/ui/pages/profile/seller_profile.dart';
import 'package:xytek/ui/widgets/listile_comment_product.dart';

import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_rounded_image.dart';

class DetailsSale extends StatelessWidget {
  DetailsSale({Key? key}) : super(key: key) {
    purchase = Get.arguments[0];
    product = Get.arguments[1];
    seller = Get.arguments[2];
    storage = Get.find();
    initValues();
  }

  final formatCurrency = NumberFormat.currency(
    decimalDigits: 0,
    symbol: '\$',
    customPattern: '\u00a4 ###,###',
  );

  initValues() {
    price = '${product.price}';
    amount = '${purchase.quantity}';

    state = "Total: " +
        formatCurrency
            .format(product.price * purchase.quantity)
            .replaceAll(',', '.');
    description = product.description;
    nameSeller = seller.name;
    category = product.category;
    dateSale = purchase.date;
    paymentMethod = purchase.paymentMethod;
    productName = product.name;
    urlProduct = product.urlImage;
    userProfile = seller.urlProfile;
  }

  late StorageController storage;
  late PurchaseModel purchase;
  late ProductModel product;
  late UserModel seller;

  //Pedir Info de una clase Product
  late String productName;
  late String urlProduct;
  late String price;
  late String amount;
  late String state;
  late String description;
  //Hay que pedir la informacion desde la clase userModel o userSaler el vendedor
  late String nameSeller;
  late String category;
  late String dateSale;
  late String paymentMethod;
  late String userProfile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  WidgetRoundedImage(image: urlProduct),
                  Text(productName,
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(category),
                  Text("$price X $amount"),
                  Text(state),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: textAlign("Datalles del producto:", 18)),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        border:
                            Border.all(color: Colors.grey.withOpacity(0.5))),
                    padding: EdgeInsets.only(left: 20),
                    height: 120,
                    child: SingleChildScrollView(
                      scrollDirection: Axis.vertical,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          description,
                        ),
                      ),
                    ),
                  ),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: textAlign("Vendedor:", 18)),
                  FutureBuilder(
                      future: storage.getInfoSellerAndRating(
                          product: product.toMap()),
                      builder: (BuildContext context, AsyncSnapshot snapshot) {
                        if (snapshot.connectionState == ConnectionState.done) {
                          if (snapshot.data == null) {
                            return Text('');
                          } else {
                            List list = snapshot.data as List;
                            UserModel? user = list[0];
                            List<RatingUserModel> listRating = list[1];
                            if (user != null) {
                              return listTile(
                                  linkImage: user.urlProfile,
                                  name: user.name,
                                  rating: storage
                                      .getAverageSellerRating(listRating),
                                  seller: user,
                                  listRatings: listRating);
                            } else {
                              return Center(
                                child: Text(
                                    "No se ha podido cargar la informacion del vendedor"),
                              );
                            }
                          }
                        } else if (snapshot.hasError) {
                          return Text(''); // error
                        } else {
                          return CircularProgressIndicator(); // loading
                        }
                      }),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: textAlign("Fecha de venta:", 18)),
                  Container(
                      padding: EdgeInsets.only(left: 20, right: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          dateSale,
                        ),
                      )),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: textAlign("Metodo de Pago:", 18)),
                  Container(
                      padding: EdgeInsets.only(left: 20, right: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          paymentMethod,
                        ),
                      )),
                  Container(
                      padding: EdgeInsets.symmetric(vertical: 10),
                      child: textAlign("Calificación del Producto:", 18)),
                  FutureBuilder(
                    builder: (context, snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
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
                          return Center(child: CircularProgressIndicator());
                        }
                      }
                    },
                    future: storage.getProductsRating(product.id),
                  )
                ],
              ),
            ],
          ),
        ));
  }

  Widget textAlign(text, double size) {
    return Container(
        padding: EdgeInsets.only(left: 10, right: 10),
        child: Align(
          alignment: Alignment.centerLeft,
          child: Text(
            text,
            overflow: TextOverflow.ellipsis,
            maxLines: 5,
            style: TextStyle(fontSize: size, fontWeight: FontWeight.bold),
          ),
        ));
  }

  /*
  linkImage is a String
  name is a STring
  rating is a Widget
  */
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
}
