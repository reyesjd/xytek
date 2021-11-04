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

  testWidgets("Authentication Test", (WidgetTester tester) async {
    Widget w = await createHome();
    await tester.pumpWidget(w);
    print("hola");
    expect(find.byKey(Key('"signupBtn"')), findsOneWidget);

    /*

    await tester.tap(find.byKey(Key('footballNewsButton')));

    await tester.pumpAndSettle();

    expect(find.byKey(Key('readMoreButton')), findsWidgets);

    // Therefore: (The command Offset uses Cartesian 'directions') - lets see: a) Left Dragging: Offset(-500.0, 0.0) b) Right Dragging: Offset(+500.0, 0.0) c) Up Dragging: Offset(0.0, +500.0) d) Down Dragging: Offset(0.0, -500.0)
    await tester.drag(find.byKey(Key('refreshList')), const Offset(0.0, 500.0));

    await tester.pumpAndSettle();

    await tester.pumpAndSettle();

    expect(find.byKey(Key('readMoreButton')), findsWidgets);

    await tester.drag(
        find.byKey(Key('dragToResetGesture')), const Offset(500.0, 0.0));

    await tester.pumpAndSettle();

    await tester.pumpAndSettle();

    expect(find.byKey(Key('readMoreButton')), findsNothing);*/
  });
}
