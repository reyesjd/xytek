import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';

import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_rounded_image.dart';

class DetailsSale extends StatelessWidget {
  DetailsSale({Key? key}) : super(key: key);

  //Pedir Info de una clase Product
  String price = "1000";
  String amount = "10";
  String state = "disponible";
  String description =
      "Esto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensaEsto es una descricion extensa";
  //Hay que pedir la informacion desde la clase userModel o userSaler el vendedor
  String nameBuyer = "Nombre del comprador";
  String category = "";
  String dateSale = "00/000/000";
  String paymentMethod = "Efectivo";

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
                  WidgetRoundedImage(
                      image:
                          "https://conceptodefinicion.de/wp-content/uploads/2015/02/tarjeta-de-video-pny-nvidia-quadro-600-1gb-ddr3-profesional.jpg"),
                  Text("Nvidia GT210",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(category),
                  Text("$price X $amount"),
                  Text(state),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  textAlign("Datalles del producto:", 18),
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
                  textAlign("Comprador:", 18),
                  listTile(
                    linkImage:
                        "https://i0.wp.com/tualquiler.cr/wp-content/uploads/2017/03/default-user.png?ssl=1",
                    name: nameBuyer,
                  ),
                  textAlign("Fecha de venta:", 18),
                  Container(
                      padding: EdgeInsets.only(left: 20, right: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          dateSale,
                        ),
                      )),
                  textAlign("Metodo de Pago:", 18),
                  Container(
                      padding: EdgeInsets.only(left: 20, right: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          dateSale,
                        ),
                      )),
                  textAlign("Metodo de Pago:", 18),
                  Container(
                      padding: EdgeInsets.only(left: 20, right: 10),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          paymentMethod,
                        ),
                      )),
                  textAlign("Calificación:", 18),
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
                          empty: Icon(Icons.star_border, color: Colors.amber)),
                    ),
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
  Widget listTile({linkImage, name, rating = null}) {
    if (rating == null) {
      return ListTile(
        leading: WidgetRoundedImage(
          image: linkImage,
          small: true,
        ),
        title: Text(name),
      );
    }
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
