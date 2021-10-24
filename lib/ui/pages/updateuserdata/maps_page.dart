import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_button.dart';

class Maps extends StatelessWidget {
  Maps({Key? key}) : super(key: key);

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
                    child: Text("Aqui va el mapa"),
                  ),
                  Row(
                    children: [
                      WidgetButton(
                          text: "Guardar Cambios",
                          onPressed: () {},
                          typeMain: true),
                    ],
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
