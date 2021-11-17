import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:xytek/data/models/rating_user_model.dart';
import 'package:xytek/data/models/user_model.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/domain/controllers/authentication/storage_controller.dart';
import 'package:xytek/ui/pages/product/add_comment.dart';
import 'package:xytek/ui/widgets/listile_comment_product.dart';

import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_rounded_image.dart';
import 'package:xytek/ui/widgets/widget_text_align.dart';

class SellerProfile extends StatelessWidget {
  SellerProfile({Key? key}) : super(key: key) {
    user = Get.arguments[0];
    listRating = Get.arguments[1];
  }

  late UserModel? user;
  late RxList listRating;
  AuthController auth = Get.find();
  StorageController storage = Get.find();

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: WidgetAppBarBack(actionButtonBack: () {
            Get.back();
          }).build(context),
          body: Container(
            padding: EdgeInsets.all(0),
            color: Color.fromRGBO(244, 244, 244, 1),
            child: Column(
              children: [
                WidgetRoundedImage(
                  image: user!.urlProfile,
                ),
                Column(
                  children: [
                    Text(user!.name,
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold)),
                    Text("Vendedor",
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w300)),
                  ],
                ),
                FutureBuilder(
                    future: storage.getSellerAverage(uid: user!.uid),
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
                                  allowHalfRating: true,
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
                    }),
                Container(
                  margin: EdgeInsets.only(left: 15, right: 15),
                  child: Row(
                    children: [
                      WidgetButton(
                          text: "Calificar Vendedor",
                          onPressed: () {
                            Get.to(() => AddComment(),
                                arguments: [user!.uid, false, listRating]);
                          },
                          typeMain: false),
                    ],
                  ),
                ),
                Container(
                    padding: EdgeInsets.only(
                      top: 20,
                    ),
                    child: WidgetAlignText(text: "Calificaciones:", size: 20)),
                Expanded(
                    flex: 1,
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
                      margin: EdgeInsets.all(15),
                      child: ListView(
                        children: [
                          ...listRating.map((userRating) {
                            return Container(
                              margin: EdgeInsets.only(
                                  right: 5, left: 5, bottom: 10),
                              child: WidgetCommentProduct(
                                  linkImage: userRating.urlImage,
                                  comment: userRating.comment,
                                  date: userRating.date,
                                  name: userRating.name,
                                  rating: userRating.rating),
                            );
                          }).toList()
                        ],
                      ),
                    ))
              ],
            ),
          ),
        ));
  }
}
