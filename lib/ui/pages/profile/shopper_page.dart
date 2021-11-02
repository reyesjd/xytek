import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/domain/controllers/authentication/storage_controller.dart';
import 'package:xytek/ui/pages/login/login_main_page.dart';
import 'package:xytek/ui/pages/profile/my_shoppings.dart';
import 'package:xytek/ui/pages/profile/seller_page.dart';
import 'package:xytek/ui/pages/updateuserdata/my_data_page.dart';

import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_profile_button.dart';
import 'package:xytek/ui/widgets/widget_rounded_image.dart';

class Shopper extends StatelessWidget {
  Shopper({Key? key}) : super(key: key);

  AuthController auth = Get.find();
  StorageController store = Get.find();

  void handlerSeller() async {
    try {
      auth.userModelLogged.isSeller = true;
      await store.updateUser(auth.userModelLogged);
      await Get.to(() => Seller());
      Get.snackbar("", "Ahora eres un vendedor");
    } catch (e) {
      Get.snackbar("", "Uy parece que hubo un error, intenta de nuevo");
    }
  }

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
                            onPressed: () {
                              Get.to(() => MyShoppings());
                            },
                          ),
                          WidgetProfileButton(
                            text: "Mis Datos",
                            onPressed: () {
                              Get.to(() => MyData());
                            },
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
                                text: "Cerrar Sesión",
                                onPressed: () async {
                                  await auth.signOut();
                                  Get.to(() => LoginMainPage());
                                },
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
                            onPressed: handlerSeller,
                            child: Text(
                                auth.userModelLogged.isSeller
                                    ? "Abrir la ventana de vendedor"
                                    : "Ser un Vendedor",
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
