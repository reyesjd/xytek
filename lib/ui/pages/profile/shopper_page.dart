import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/domain/controllers/authentication/storage_controller.dart';
import 'package:xytek/ui/pages/home/main.dart';
import 'package:xytek/ui/pages/profile/my_shoppings.dart';
import 'package:xytek/ui/pages/profile/seller_page.dart';
import 'package:xytek/ui/pages/updateuserdata/my_data_page.dart';
import 'package:xytek/ui/widgets/custom_snackbar.dart';

import 'package:xytek/ui/widgets/widget_appbar_back.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_profile_button.dart';
import 'package:xytek/ui/widgets/widget_rounded_image.dart';

// ignore: must_be_immutable
class Shopper extends StatelessWidget {
  Shopper({Key? key}) : super(key: key);

  StorageController store = Get.find();

  final _loading = false.obs;
  bool get loading => _loading.value;
  set loading(bool value) => _loading.value = value;

  @override
  Widget build(BuildContext context) {
    var media = MediaQuery.of(context).size;
    return GetX(builder: (AuthController auth) {
      void handlerSeller() async {
        try {
          auth.userModelLogged.isSeller = true;
          await store.updateUser(uid: auth.userModelLogged.uid, isSeller: true);
          Get.to(() => Seller());
          getCustomSnackbar(
            "Perfil de Vendedor",
            auth.userModelLogged.isSeller
                ? "Ahora estás en la ventana de vendedor"
                : "Ahora eres un vendedor",
            type: CustomSnackbarType.info,
          );
        } catch (e) {
          getCustomSnackbar(
            "",
            "Uy parece que hubo un error, intenta de nuevo",
            type: CustomSnackbarType.error,
          );
        }
      }

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
                        image: auth.userModelLogged.urlProfile,
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Column(
                          children: [
                            Text(auth.userModelLogged.name,
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
                              keyProfileButton: Key("myshopsBtn"),
                              text: "Mis Compras",
                              onPressed: () {
                                Get.to(() => MyShoppings());
                              },
                            ),
                            WidgetProfileButton(
                              keyProfileButton: Key("mydataBtn"),
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
                              Obx(
                                () => WidgetButton(
                                  loading: loading,
                                  keyButton: Key("signoutBtn"),
                                  text: "Cerrar Sesión",
                                  onPressed: () async {
                                    if (!loading) {
                                      loading = true;
                                      await auth.signOut();
                                      Get.to(() => Main());
                                      loading = false;
                                    }
                                  },
                                  typeMain: false,
                                ),
                              )
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
                              key: Key("tosellerBtn"),
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
    });
  }
}
