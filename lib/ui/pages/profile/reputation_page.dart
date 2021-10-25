import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:flutter_rating_bar/flutter_rating_bar.dart';

import 'package:xytek/ui/widgets/widget_appbar_back.dart';

import 'package:xytek/ui/widgets/widget_opinion.dart';

import 'package:xytek/ui/widgets/widget_rounded_image.dart';

class Reputation extends StatelessWidget {
  Reputation({Key? key}) : super(key: key);

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
                    flex: 2,
                    child: WidgetRoundedImage(
                      image: 'https://googleflutter.com/sample_image.jpg',
                    ),
                  ),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text("Jhon Doe",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                          Text("Vendedor",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w300)),
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Column(
                        children: [
                          Text("Reputacion",
                              style: TextStyle(
                                  fontSize: 24, fontWeight: FontWeight.bold)),
                          Container(
                            margin: EdgeInsets.only(top: 2),
                            child: RatingBar(
                              ignoreGestures: true,
                              updateOnDrag: false,
                              itemCount: 5,
                              allowHalfRating: false,
                              initialRating: 3,
                              onRatingUpdate: (double value) {},
                              ratingWidget: RatingWidget(
                                  full: Icon(Icons.star, color: Colors.amber),
                                  half: Icon(
                                    Icons.star_border,
                                    color: Colors.white,
                                  ),
                                  empty: Icon(Icons.star_border,
                                      color: Colors.amber)),
                            ),
                          )
                        ],
                      )),
                  Text("Opiniones",
                      style:
                          TextStyle(fontSize: 24, fontWeight: FontWeight.bold)),
                  Expanded(
                      flex: 4,
                      child: ListView(
                        children: [
                          WidgetOpinion(
                            name: "Nombre Comprador",
                            rating: 2,
                            comment:
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent tellus lorem, auctor aliquet tellus nec, tincidunt fermentum nisi. Vivamus diam.",
                          ),
                          WidgetOpinion(
                            name: "Nombre Comprador",
                            rating: 2,
                            comment:
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent tellus lorem, auctor aliquet tellus nec, tincidunt fermentum nisi. Vivamus diam.",
                          ),
                          WidgetOpinion(
                            name: "Nombre Comprador",
                            rating: 2,
                            comment:
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent tellus lorem, auctor aliquet tellus nec, tincidunt fermentum nisi. Vivamus diam.",
                          ),
                          WidgetOpinion(
                            name: "Nombre Comprador",
                            rating: 2,
                            comment:
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent tellus lorem, auctor aliquet tellus nec, tincidunt fermentum nisi. Vivamus diam.",
                          ),
                          WidgetOpinion(
                            name: "Nombre Comprador",
                            rating: 2,
                            comment:
                                "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Praesent tellus lorem, auctor aliquet tellus nec, tincidunt fermentum nisi. Vivamus diam.",
                          ),
                        ],
                      )),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
