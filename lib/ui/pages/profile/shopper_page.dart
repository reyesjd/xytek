import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_profile_button.dart';
import 'package:xytek/ui/widgets/widget_rounded_image.dart';

class Shopper extends StatelessWidget {
  Shopper({Key? key}) : super(key: key);

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
                    flex: 3,
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
                          Text("Comprador",
                              style: TextStyle(
                                  fontSize: 18, fontWeight: FontWeight.w300))
                        ],
                      )),
                  Expanded(
                      flex: 3,
                      child: Column(
                        children: [
                          WidgetProfileButton(
                            text: "Mis Compras",
                            onPressed: () {},
                          ),
                          WidgetProfileButton(
                            text: "Mis Compras",
                            onPressed: () {},
                          )
                        ],
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 15, right: 15),
                        child: Row(
                          children: [
                            WidgetButton(
                                text: "Guardar Cambios",
                                onPressed: () {},
                                typeMain: false),
                          ],
                        ),
                      )),
                  Expanded(
                      flex: 1,
                      child: Container(
                        margin: EdgeInsets.only(left: 30),
                        child: Align(
                          alignment: Alignment.centerLeft,
                          child: TextButton(
                            onPressed: () {},
                            child: Text("Ser un Vendedor",
                                style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w300,
                                    color: Color.fromRGBO(51, 51, 51, 1))),
                          ),
                        ),
                      ))
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
