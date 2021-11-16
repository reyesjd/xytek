import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xytek/data/models/rating_product_model.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/domain/controllers/authentication/storage_controller.dart';
import 'package:xytek/ui/pages/product/edit_products.dart';
import 'package:xytek/ui/widgets/listile_comment_product.dart';
import 'package:xytek/ui/widgets/widget_rounded_image.dart';

class OpenDetailsSale extends StatelessWidget {
  OpenDetailsSale({Key? key}) : super(key: key) {
    product = RxMap(Get.arguments[0]);
  }

  AuthController auth = Get.find();
  StorageController storage = Get.find();
  late RxMap<String, dynamic> product;

  final formatCurrency = NumberFormat.currency(
    decimalDigits: 0,
    symbol: '\$',
    customPattern: '\u00a4 ###,###',
  );

  String amount = "10";

  //Hay que pedir la informacion desde la clase userModel o userSaler el vendedor
  String nameBuyer = "Nombre del comprador";

  String dateSale = "00/000/000";
  String paymentMethod = "Efectivo";

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
        appBar: AppBar(
          actions: [
            TextButton.icon(
                key: Key("editBtn"),
                onPressed: () {
                  Get.to(() => EditProduct(), arguments: [product])
                      ?.then((value) {
                    if (value != null) {
                      product = value;
                    }
                  });
                },
                icon: Icon(
                  Icons.edit,
                ),
                label: Text("Editar Producto"))
          ],
          leading: IconButton(
              color: Colors.black,
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back)),
          backgroundColor: Color.fromRGBO(244, 244, 244, 1),
          elevation: 0,
        ),
        body: Container(
          padding: EdgeInsets.all(20),
          color: Color.fromRGBO(244, 244, 244, 1),
          child: Column(
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  WidgetRoundedImage(image: product["urlImage"]),
                  Text(product["name"],
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                  Text(product["category"]),
                  Text(
                    formatCurrency
                        .format(product["price"])
                        .replaceAll(',', '.'),
                  ),
                  Text(int.parse(amount) > 0
                      ? "$amount disponibles"
                      : "no disponible"),
                ],
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  textAlign("Compradores:", 18),
                  listTile(
                    linkImage:
                        "https://i0.wp.com/tualquiler.cr/wp-content/uploads/2017/03/default-user.png?ssl=1",
                    name: nameBuyer,
                  ),
                  listTile(
                    linkImage:
                        "https://i0.wp.com/tualquiler.cr/wp-content/uploads/2017/03/default-user.png?ssl=1",
                    name: nameBuyer,
                  ),
                  textAlign("Calificaciones:", 18),
                ],
              ),
              Expanded(
                  flex: 4,
                  child: FutureBuilder(
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
                        return ListView(
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
                    future: storage.getProductsRating(product["id"]),
                  ))
            ],
          ),
        )));
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
