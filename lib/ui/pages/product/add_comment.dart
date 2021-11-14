import 'package:flutter/material.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:get/get.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_text_field.dart';

class AddComment extends StatelessWidget {
  AddComment({Key? key, isProduct = true, required this.onPressed})
      : super(key: key) {
    commentController = TextEditingController();
    globalKey = GlobalKey<FormState>();
    valueRating = RxDouble(0);
  }

  late GlobalKey<FormState> globalKey;
  late TextEditingController commentController;
  late bool isProduct;
  late RxDouble valueRating;
  late Function onPressed;

  @override
  Widget build(BuildContext context) {
    return Obx(() => Scaffold(
          body: Column(
            children: [
              Form(
                child: Container(
                  color: Color.fromRGBO(244, 244, 244, 1),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Text(isProduct
                          ? "Calificar producto"
                          : "Calificar vendedor"),
                      WidgetTextField(
                          label: "Comentario",
                          controller: commentController,
                          validator: (value) {
                            if (value!.isEmpty) {
                              return "El comentario no puede estar vacio";
                            }
                          },
                          obscure: false,
                          digitsOnly: false),
                      RatingBar(
                        itemSize: 20,
                        ignoreGestures: true,
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
                            empty:
                                Icon(Icons.star_border, color: Colors.amber)),
                      ),
                      WidgetButton(
                          text: "Calificar",
                          onPressed: () {
                            if (isProduct) {
                              
                            } else {}
                            onPressed();
                          },
                          typeMain: true)
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
