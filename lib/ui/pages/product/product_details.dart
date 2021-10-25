import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_rounded_image.dart';
import 'package:xytek/ui/widgets/widget_text_align.dart';

class DetailsProduct extends StatelessWidget {
  DetailsProduct({Key? key}) : super(key: key);

  //Pedir Info de una clase Product
  String category = "RAM";
  String price = "1000";
  String amount = "10";
  String state = "disponible";
  String description =
      "Esto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensa";
  //Hay que pedir la informacion desde la clase userModel o userSaler el vendedor
  String nameSaler = "Nombre del vendedor";
  String ratingSaler = "";

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return Scaffold(
        appBar: WidgetAppBarBack(actionButtonBack: () {
          Get.back();
        }).build(context),
        body: Container(
          padding: EdgeInsets.all(20),
          color: Color.fromRGBO(244, 244, 244, 1),
          child: ListView(
            children: [
              SizedBox(
                height: media.height - 130,
                child: Column(
                  children: [
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          WidgetRoundedImage(
                              image:
                                  "https://conceptodefinicion.de/wp-content/uploads/2015/02/tarjeta-de-video-pny-nvidia-quadro-600-1gb-ddr3-profesional.jpg"),
                          Text("Nvidia GT210",
                              style: TextStyle(
                                  fontSize: 20, fontWeight: FontWeight.bold)),
                          Text(category),
                          Text("$price X $amount"),
                          Text(state),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          WidgetAlignText(
                              text: "Datalles del producto:", size: 18),
                          Container(
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
                          WidgetAlignText(text: "Vendedor:", size: 18),
                          listTile(
                              linkImage:
                                  "https://i0.wp.com/tualquiler.cr/wp-content/uploads/2017/03/default-user.png?ssl=1",
                              name: nameSaler,
                              rating: Container(
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
                              )),
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        WidgetButton(
                            text: "Añadir al carrito",
                            onPressed: () {},
                            typeMain: true),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ));
  }

  Widget listTile({linkImage, name, rating}) {
    return ListTile(
      leading: WidgetRoundedImage(
        image: linkImage,
        small: true,
      ),
      title: Text(name),
      subtitle: rating,
    );
  }
}
