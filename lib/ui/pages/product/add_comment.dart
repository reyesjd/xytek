import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/domain/controllers/authentication/storage_controller.dart';
import 'package:xytek/ui/widgets/custom_snackbar.dart';
import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_text_align.dart';
import 'package:xytek/ui/widgets/widget_text_field.dart';

class AddComment extends StatelessWidget {
  AddComment({
    Key? key,
  }) : super(key: key) {
    commentController = TextEditingController();
    globalKey = GlobalKey<FormState>();
    valueRating = RxDouble(0);
    storage = Get.find();
    auth = Get.find();
    id = Get.arguments[0];
    isProduct = Get.arguments[1];
    if (Get.arguments.length > 2) {
      listComments = Get.arguments[2];
    }
  }

  final _formKey = GlobalKey<FormState>();
  late GlobalKey<FormState> globalKey;
  late TextEditingController commentController;
  late bool isProduct;
  late RxDouble valueRating;
  late StorageController storage;
  late AuthController auth;
  final url = "https://i1.sndcdn.com/avatars-000396582750-afqhbt-t240x240.jpg";
  late String id;
  RxBool isLoading = false.obs;
  // ignore: prefer_typing_uninitialized_variables
  var listComments;

  addcomment() async {
    isLoading.value = true;
    final form = _formKey.currentState;
    try {
      form!.save();
      if (form.validate()) {
        if (isProduct) {
          await storage.addNewCommentProduct(
              name: auth.userModelLogged.name,
              urlImage: url,
              idShopperUser: auth.userIDLogged,
              idProduct: id,
              rating: valueRating.value,
              comment: commentController.text);
        } else {
          await storage.addNewCommentUser(
              name: auth.userModelLogged.name,
              urlImage: url,
              idShopperUser: auth.userIDLogged,
              idSeller: id,
              rating: valueRating.value,
              comment: commentController.text,
              listCommentsOBX: listComments);
        }
      }
      Get.back();
      getCustomSnackbar(
        "Comentario Exitoso",
        "Se ha agregado correctamente el comentario",
        type: CustomSnackbarType.success,
      );
    } catch (e) {
      getCustomSnackbar(
        "Error con el comentario",
        "No ha sido posible agregar el comentario, intentelo nuevamente",
        type: CustomSnackbarType.error,
      );
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
                    child: Row(
                      children: [
                        WidgetButton(
                          text: "Calificar",
                          onPressed: addcomment,
                          typeMain: true,
                          loading: isLoading.value,
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
