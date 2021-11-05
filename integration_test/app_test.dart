import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:get/get.dart';
import 'package:integration_test/integration_test.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/domain/controllers/authentication/storage_controller.dart';
import 'package:xytek/domain/use_case/authentication/authentication_use_case.dart';
import 'package:xytek/domain/use_case/authentication/storage_use_case.dart';
import 'package:xytek/ui/my_app.dart';

Future<Widget> createHome() async {
  WidgetsFlutterBinding.ensureInitialized();
  //vars for Authentication
  Get.lazyPut<AuthController>(() => AuthController());
  Get.lazyPut<Auth>(() => Auth());

  //vars for Storage
  Get.lazyPut<StorageController>(() => StorageController());
  Get.lazyPut<Storage>(() => Storage());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  return MyApp();
}

void main() {
  IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  
  testWidgets("Signup", (WidgetTester tester) async {
    Widget w = await createHome();

    await tester.pumpWidget(w);

    await tester.pumpAndSettle(Duration(seconds: 10));

    expect(find.byKey(Key("signupBtn")), findsOneWidget);

    await tester.tap(find.byKey(Key("signupBtn")));
    await tester.pump();
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.text("Crea tu Nueva Cuenta"), findsOneWidget);

    expect(find.byKey(Key("nameTf")), findsOneWidget);
    expect(find.byKey(Key("emailTf")), findsOneWidget);
    expect(find.byKey(Key("phoneTf")), findsOneWidget);
    expect(find.byKey(Key("nextBtn")), findsOneWidget);

    await tester.enterText(find.byKey(Key("nameTf")), 'Pedro Perez');
    await tester.enterText(find.byKey(Key("emailTf")), 'pperez@email.com');
    await tester.enterText(find.byKey(Key("phoneTf")), '3015439863');

    await tester.drag(find.byKey(Key("signLv")), const Offset(0.0, -500.0));
    await tester.pumpAndSettle(Duration(seconds: 2));

    await tester.tap(find.byKey(Key("nextBtn")));
    await tester.pump();
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.text("Ya casi está"), findsOneWidget);

    expect(find.byKey(Key("userTf")), findsOneWidget);
    expect(find.byKey(Key("passwordTf")), findsOneWidget);
    expect(find.byKey(Key("confirpassTf")), findsOneWidget);
    expect(find.byKey(Key("signupBtn")), findsOneWidget);

    await tester.enterText(find.byKey(Key("userTf")), 'pperez');
    await tester.enterText(find.byKey(Key("passwordTf")), 'pp123456@');
    await tester.enterText(find.byKey(Key("confirpassTf")), 'pp123456@');

    await tester.drag(find.byKey(Key("signupLv")), const Offset(0.0, -500.0));
    await tester.pumpAndSettle(Duration(seconds: 2));

    await tester.tap(find.byKey(Key("signupBtn")));

    await tester.pumpAndSettle(Duration(seconds: 15));

    //  expect(find.text("Registro exitoso"), findsOneWidget);

    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.byKey(Key("emailBtn")), findsOneWidget);
  });

  testWidgets("Signin", (WidgetTester tester) async {
    Widget w = await createHome();

    await tester.pumpWidget(w);

    await tester.pumpAndSettle(Duration(seconds: 10));

    expect(find.byKey(Key("emailBtn")), findsOneWidget);

    await tester.tap(find.byKey(Key("emailBtn")));

    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.byKey(Key("userTf")), findsOneWidget);
    expect(find.byKey(Key("passwordTf")), findsOneWidget);
    expect(find.byKey(Key("loginByEmailBtn")), findsOneWidget);

    await tester.enterText(find.byKey(Key("userTf")), 'pperez@email.com');
    await tester.enterText(find.byKey(Key("passwordTf")), 'pp123456@');

    await tester.tap(find.byKey(Key("loginByEmailBtn")));
    await tester.pumpAndSettle(Duration(seconds: 15));
  });

  testWidgets("Add new product", (WidgetTester tester) async {
    Widget w = await createHome();

    await tester.pumpWidget(w);

    await tester.pumpAndSettle(Duration(seconds: 10));

    //expect(find.byKey(Key("drawer")), findsOneWidget);
    await tester.dragFrom(
        tester.getTopLeft(find.byType(MaterialApp)), Offset(300, 0));

    // await tester.tap(find.byKey(Key("drawer")));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.byKey(Key("profileBtn")), findsOneWidget);

    await tester.tap(find.byKey(Key("profileBtn")));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.text('Pedro Perez'), findsOneWidget);

    expect(find.byKey(Key("myshopsBtn")), findsOneWidget);
    expect(find.byKey(Key("mydataBtn")), findsOneWidget);
    expect(find.byKey(Key("tosellerBtn")), findsOneWidget);

    await tester.tap(find.byKey(Key("tosellerBtn")));
    await tester.pumpAndSettle(Duration(seconds: 10));

    expect(find.text('Pedro Perez'), findsOneWidget);

    expect(find.byKey(Key("mysalesBtn")), findsOneWidget);
    expect(find.byKey(Key("mydataBtn")), findsOneWidget);
    expect(find.byKey(Key("salesproductsBtn")), findsOneWidget);

    await tester.tap(find.byKey(Key("salesproductsBtn")));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.byKey(Key("addBtn")), findsOneWidget);

    await tester.tap(find.byKey(Key("addBtn")));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.text("Nuevo Producto"), findsOneWidget);

    expect(find.byKey(Key("nameTf")), findsOneWidget);
    expect(find.byKey(Key("priceTf")), findsOneWidget);
    expect(find.byKey(Key("descriptionTf")), findsOneWidget);
    expect(find.byKey(Key("categoryDb")), findsOneWidget);
    expect(find.byKey(Key("urlTf")), findsOneWidget);
    expect(find.byKey(Key("addproductBtn")), findsOneWidget);

    await tester.enterText(find.byKey(Key("nameTf")), 'Asus H81m-k');
    await tester.enterText(find.byKey(Key("priceTf")), '450000');
    await tester.enterText(find.byKey(Key("descriptionTf")),
        'Placa base Asus chipset H81, socket LGA-1150 y soporte para la cuarta generacion de intel.');
    await tester.enterText(find.byKey(Key("urlTf")),
        'https://ae01.alicdn.com/kf/HTB1wlKmN7voK1RjSZFNq6AxMVXai/Placa-base-LGA-1150-ASUS-H81M-K-Micro-ATX-H81M-K-H81M-DDR3-para-Intel-H81.jpg');

    await tester.drag(
        find.byKey(Key("addproducLv")), const Offset(0.0, -500.0));
    await tester.pumpAndSettle(Duration(seconds: 2));

    await tester.tap(find.byKey(Key("addproductBtn")));
    await tester.pumpAndSettle(Duration(seconds: 15));
  });

  testWidgets("edit product", (WidgetTester tester) async {
    Widget w = await createHome();

    await tester.pumpWidget(w);

    await tester.pumpAndSettle(Duration(seconds: 10));

    //expect(find.byKey(Key("drawer")), findsOneWidget);
    await tester.dragFrom(
        tester.getTopLeft(find.byType(MaterialApp)), Offset(300, 0));

    // await tester.tap(find.byKey(Key("drawer")));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.byKey(Key("profileBtn")), findsOneWidget);

    await tester.tap(find.byKey(Key("profileBtn")));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.text('Pedro Perez'), findsOneWidget);

    expect(find.byKey(Key("myshopsBtn")), findsOneWidget);
    expect(find.byKey(Key("mydataBtn")), findsOneWidget);
    expect(find.byKey(Key("tosellerBtn")), findsOneWidget);

    await tester.tap(find.byKey(Key("tosellerBtn")));
    await tester.pumpAndSettle(Duration(seconds: 10));

    expect(find.text('Pedro Perez'), findsOneWidget);

    expect(find.byKey(Key("mysalesBtn")), findsOneWidget);
    expect(find.byKey(Key("mydataBtn")), findsOneWidget);
    expect(find.byKey(Key("salesproductsBtn")), findsOneWidget);

    await tester.tap(find.byKey(Key("salesproductsBtn")));
    await tester.pumpAndSettle(Duration(seconds: 5));
    //Creo que despues de estos explotara
    expect(find.text("Productos en venta"), findsOneWidget);
    expect(find.text('Asus H81m-k'), findsOneWidget);

    //en este tap puede explotar porque no se como hacer tap en el ProductCard sin saber el id que da la bd
    await tester.tap(find.text('Asus H81m-k'));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.byKey(Key("editBtn")), findsOneWidget);

    await tester.tap(find.byKey(Key("editBtn")));
    await tester.pumpAndSettle(Duration(seconds: 5));

    expect(find.text("Actualiza tu Producto"), findsOneWidget);
    expect(find.byKey(Key("priceTf")), findsOneWidget);

    await tester.enterText(find.byKey(Key("priceTf")), '');
    await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.enterText(find.byKey(Key("priceTf")), '1000000');

    await tester.drag(
        find.byKey(Key("editproductLv")), const Offset(0.0, -500.0));

    await tester.pumpAndSettle(Duration(seconds: 2));
    await tester.drag(
        find.byKey(Key("editproductLv")), const Offset(0.0, -500.0));
    await tester.pumpAndSettle(Duration(seconds: 2));

    await tester.tap(find.byKey(Key("updateproductBtn")));
    await tester.pumpAndSettle(Duration(seconds: 15));

//    expect(find.byKey(Key("editBtn")), findsOneWidget);
  });
}
