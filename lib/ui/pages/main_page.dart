import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/data/models/user_model.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_text_field.dart';

class MainPage extends StatelessWidget {
  MainPage({
    Key? key,
  }) : super(key: key);

  String getInfoUser() {
    AuthController controller = Get.find();
    if (controller.userModelLogged != null) {
      UserModel user = controller.userModelLogged as UserModel;
      return user.toMap().toString();
    }
    return "El usuario no tiene informacion";
  }

  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
        resizeToAvoidBottomInset: false,
        appBar: AppBar(
          leading: IconButton(
              color: Colors.black,
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back)),
          backgroundColor: Color.fromRGBO(244, 244, 244, 1),
          elevation: 0,
        ),
        body: Center(
          child: Column(
            children: [
              Text("Estás en el Main"),
              Text(getInfoUser()),
              WidgetButton(
                  text: "Cerrar sesion",
                  onPressed: () async {
                    AuthController authController = Get.find();
                    await authController.signOut();
                  },
                  typeMain: true)
            ],
          ),
        ));
  }
}
