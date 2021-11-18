import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/ui/pages/home/main.dart';
import 'package:xytek/ui/pages/login/login_recovery_password.dart';
import 'package:xytek/ui/widgets/custom_snackbar.dart';
import 'package:xytek/ui/widgets/widget_button.dart';
import 'package:xytek/ui/widgets/widget_text_field.dart';

class LoginCredentials extends StatelessWidget {
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  String errorMessage = "No se ha podido ingresar a la aplicación";
  bool logged = false;
  final _loading = false.obs;

  bool get loading {
    return _loading.value;
  }

  set loading(bool value) {
    _loading.value = value;
  }

  bool isEmail(String em) {
    String p =
        r"^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9-]+(?:\.[a-zA-Z0-9-]+)*$";

    RegExp regExp = RegExp(p);

    return regExp.hasMatch(em);
  }

  login(email, password) async {
    AuthController authController = Get.find();
    try {
      await authController.loginByCredentials(email, password);
      logged = true;
    } catch (e) {
      logged = false;
      switch (e) {
        case "invalid-email":
          {
            errorMessage = "El correo ingresado no es valido";
            break;
          }

        case "user-disabled":
          {
            errorMessage =
                "El correo ingresado no se encuentra avilitado para ingresar a la aplicación";
            break;
          }

        case "user-not-found":
          {
            errorMessage = "El correo ingresado no se encuentra registrado";
            break;
          }
        case "wrong-password":
          {
            errorMessage = "La contraseña ingresada está errada";
            break;
          }
      }
    }
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
        body: Form(
          key: _formKey,
          child: Container(
            padding: EdgeInsets.all(20),
            color: Color.fromRGBO(244, 244, 244, 1),
            child: LayoutBuilder(
              builder: (context, constraint) {
                return SingleChildScrollView(
                  child: ConstrainedBox(
                    constraints:
                        BoxConstraints(minHeight: constraint.maxHeight),
                    child: IntrinsicHeight(
                      child: Column(
                        children: <Widget>[
                          Expanded(
                            flex: 3,
                            child: Center(
                              child: Image(
                                image: AssetImage("assets/logo/logo.png"),
                                width: 130,
                                height: 130,
                              ),
                            ),
                          ),
                          Expanded(
                            flex: 7,
                            child: Center(
                              child: Column(
                                children: [
                                  WidgetTextField(
                                    keyText: Key("userTf"),
                                    label: "Email",
                                    controller: _email,
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return "Por favor ingrese su E-mail.";
                                      } else if (!isEmail(value)) {
                                        return "Por favor ingrese un E-mail valido.";
                                      }
                                    },
                                    obscure: false,
                                    digitsOnly: false,
                                  ),
                                  WidgetTextField(
                                      keyText: Key("passwordTf"),
                                      label: "Contraseña",
                                      controller: _password,
                                      validator: (value) {
                                        if (value!.isEmpty) {
                                          return "Por favor ingrese una contraseña.";
                                        }
                                      },
                                      obscure: true,
                                      digitsOnly: false),
                                  Container(
                                    padding:
                                        EdgeInsets.only(left: 30, right: 30),
                                    child: Row(
                                      children: [
                                        Obx(
                                          () => WidgetButton(
                                            loading: loading,
                                            keyButton: Key("loginByEmailBtn"),
                                            text: "Iniciar Sesión",
                                            onPressed: () async {
                                              if (!loading) {
                                                loading = true;
                                                final form =
                                                    _formKey.currentState;
                                                form!.save();
                                                if (form.validate()) {
                                                  await login(
                                                    _email.text,
                                                    _password.text,
                                                  );
                                                  if (logged) {
                                                    Get.back();
                                                    Get.to(() => Main());
                                                    getCustomSnackbar(
                                                        "Ha ingresado correctamente",
                                                        "Los datos ingresados han sido correctos",
                                                        type: CustomSnackbarType
                                                            .success);
                                                  } else {
                                                    getCustomSnackbar(
                                                      "Ha ocurrido un error al ingresar",
                                                      errorMessage,
                                                      type: CustomSnackbarType
                                                          .error,
                                                    );
                                                  }
                                                }
                                                loading = false;
                                              }
                                            },
                                            typeMain: true,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  TextButton(
                                    key: Key("recoveryBtn"),
                                    style: TextButton.styleFrom(
                                      padding: const EdgeInsets.all(16.0),
                                      primary: Colors.grey,
                                    ),
                                    onPressed: () {
                                      Get.to(() => LoginRecoveryPassword());
                                    },
                                    child:
                                        const Text('¿Olvidaste tu contraseña?'),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ));
  }
}
