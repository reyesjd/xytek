import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:xytek/data/models/product_model.dart';
import 'package:xytek/data/models/user_model.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/domain/controllers/authentication/storage_controller.dart';
import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_text_align.dart';
import 'package:xytek/ui/widgets/widget_text_field.dart';

class AddComment extends StatelessWidget {
  AddComment({Key? key, this.isProduct = true}) : super(key: key) {
    commentController = TextEditingController();
    globalKey = GlobalKey<FormState>();
    valueRating = RxDouble(0);
    storage = Get.find();
    auth = Get.find();
  }

  final _formKey = GlobalKey<FormState>();
  late GlobalKey<FormState> globalKey;
  late TextEditingController commentController;
  late bool isProduct;
  late RxDouble valueRating;
  late StorageController storage;
  late AuthController auth;
  final url = "https://i1.sndcdn.com/avatars-000396582750-afqhbt-t240x240.jpg";
  ProductModel? product = Get.arguments[0];
  UserModel? user;
  RxBool isLoading = false.obs;

  addcomment() async {
    isLoading.value = true;
    final form = _formKey.currentState;
    try {
      form!.save();
      if (form.validate()) {
        if (isProduct) {
          if (product != null) {
            await storage.addNewCommentProduct(
                name: auth.userModelLogged.name,
                urlImage: url,
                idShopperUser: auth.userIDLogged,
                idProduct: product!.id,
                rating: valueRating.value,
                comment: commentController.text);
          }
        } else {
          if (user != null) {
            await storage.addNewCommentUser(
                name: auth.userModelLogged.name,
                urlImage: url,
                idShopperUser: auth.userIDLogged,
                idUser: user!.uid,
                rating: valueRating.value,
                comment: commentController.text);
          }
        }
      }
      Get.back();
      Get.snackbar(
          "Comentario Exitoso", "Se ha agregado correctamente el comentario");
    } catch (e) {
      Get.snackbar(
          "Error con el comentario", "No ha sido posible agregar el comentario, intentelo nuevamente");
      isLoading.value = false;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          appBar: WidgetAppBarBack(actionButtonBack: () {
            Get.back();
          }).build(context),
          body: Form(
            key: _formKey,
            child: Container(
              color: Color.fromRGBO(244, 244, 244, 1),
              child: ListView(
                children: [
                  Container(
                    padding: EdgeInsets.only(left: 10, bottom: 20),
                    child: Text(
                      isProduct ? "Calificar producto" : "Calificar vendedor",
                      overflow: TextOverflow.ellipsis,
                      maxLines: 5,
                      style:
                          TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                    ),
                  ),
                  WidgetTextField(
                    label: "Comentario",
                    controller: commentController,
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "El comentario no puede estar vacio";
                      }
                    },
                    obscure: false,
                    digitsOnly: false,
                    maxLine: 10,
                  ),
                  Container(
                    child: WidgetAlignText(text: "Puntuación:", size: 18),
                    padding: EdgeInsets.only(top: 20, bottom: 10),
                  ),
                  Container(
                    padding: EdgeInsets.only(left: 10),
                    child: RatingBar(
                      itemSize: 50,
                      ignoreGestures: false,
                      updateOnDrag: true,
                      itemCount: 5,
                      allowHalfRating: true,
                      initialRating: valueRating.value,
                      onRatingUpdate: (double value) {
                        valueRating.value = value;
                      },
                      ratingWidget: RatingWidget(
                          full: Icon(Icons.star, color: Colors.amber),
                          half: Icon(Icons.star_half, color: Colors.amber),
                          empty: Icon(Icons.star_border, color: Colors.amber)),
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 10),
                    child: WidgetButton(
                      text: "Calificar",
                      onPressed: addcomment,
                      typeMain: true,
                      loading: isLoading.value,
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
