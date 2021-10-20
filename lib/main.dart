import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/domain/use_case/authentication/authentication_use_case.dart';
import 'package:xytek/ui/my_app.dart';

Future<void> main() async {
  Get.lazyPut<AuthController>(() => AuthController());
  Get.lazyPut<Auth>(() => Auth());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
