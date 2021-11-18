import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/data/models/rating_user_model.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/domain/controllers/authentication/storage_controller.dart';
import 'package:xytek/ui/pages/login/login_main_page.dart';
import 'package:xytek/ui/pages/product/products_on_sale.dart';

import 'package:xytek/ui/pages/profile/seller_profile.dart';
import 'package:xytek/ui/pages/profile/sold_products.dart';
import 'package:xytek/ui/pages/updateuserdata/my_data_page.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_profile_button.dart';
import 'package:xytek/ui/widgets/widget_rounded_image.dart';

class Seller extends StatelessWidget {
  Seller({Key? key}) : super(key: key);

  AuthController auth = Get.find();
  StorageController storage = Get.find();

  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: WidgetAppBarBack(actionButtonBack: () {
        Get.back();
      }).build(context),
      body: Container(
        padding: EdgeInsets.all(0),
        color: Color.fromRGBO(244, 244, 244, 1),
        child: ListView(
          children: [
            WidgetRoundedImage(
              image: auth.userModelLogged.urlProfile,
            ),
            Column(
              children: [
                Text(auth.userModelLogged.name,
                    style:
                        TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                Text("Vendedor",
                    style:
                        TextStyle(fontSize: 18, fontWeight: FontWeight.w300)),
                FutureBuilder(
                    future:
                        storage.getSellerAverage(uid: auth.userModelLogged.uid),
                    builder: (BuildContext context, AsyncSnapshot snapshot) {
                      if (snapshot.connectionState == ConnectionState.done) {
                        if (snapshot.data == null) {
                          return Text('');
                        } else {
                          return TextButton(
                              key: Key("reputationBtn"),
                              onPressed: () async {
                                List<RatingUserModel> list = await storage
                                    .getUserRatings(auth.userIDLogged);
                                Get.to(() => SellerProfile(),
                                    arguments: [auth.userModelLogged, list]);
                              },
                              child: Container(
                                margin: EdgeInsets.only(top: 2),
                                child: RatingBar(
                                  ignoreGestures: true,
                                  updateOnDrag: false,
                                  itemCount: 5,
                                  allowHalfRating: false,
                                  initialRating: snapshot.data,
                                  onRatingUpdate: (double value) {},
                                  ratingWidget: RatingWidget(
                                      full:
                                          Icon(Icons.star, color: Colors.amber),
                                      half: Icon(Icons.star_half,
                                          color: Colors.amber),
                                      empty: Icon(Icons.star_border,
                                          color: Colors.amber)),
                                ),
                              ));
                        }
                      } else if (snapshot.hasError) {
                        return Text(''); // error
                      } else {
                        return CircularProgressIndicator(); // loading
                      }
                    })
              ],
            ),
            Column(
              children: [
                WidgetProfileButton(
                  keyProfileButton: Key("mysalesBtn"),
                  text: "Mis Ventas",
                  onPressed: () {
                    Get.to(() => SoldProducts());
                  },
                ),
                WidgetProfileButton(
                  keyProfileButton: Key("mydataBtn"),
                  text: "Mis Datos",
                  onPressed: () {
                    Get.to(() => MyData());
                  },
                ),
                WidgetProfileButton(
                  keyProfileButton: Key("salesproductsBtn"),
                  text: "Productos en Venta",
                  onPressed: () {
                    Get.to(() => ProductsOnSale());
                  },
                )
              ],
            ),
            Container(
              margin: EdgeInsets.only(left: 15, right: 15),
              child: Row(
                children: [
                  Obx(
                    () => WidgetButton(
                      loading: loading,
                      keyButton: Key("signoutBtn"),
                      text: "Cerrar Sesión",
                      onPressed: () async {
                        if (!loading) {
                          loading = true;
                          await auth.signOut();
                          Get.to(() => LoginMainPage());
                          loading = false;
                        }
                      },
                      typeMain: false,
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(left: 30),
              child: Align(
                alignment: Alignment.centerLeft,
                child: TextButton(
                  onPressed: () {
                    var val = Get.isSnackbarOpen;
                    if (val != null) {
                      if (val == true) {
                        Get.close(2);
                      }
                    }
                  },
                  child: Text("Volver a Comprador",
                      key: Key("toshopperBtn"),
                      style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w300,
                          color: Color.fromRGBO(51, 51, 51, 1))),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
