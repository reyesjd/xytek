import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loggy/loggy.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/domain/use_case/authentication/authentication_use_case.dart';
import 'package:xytek/ui/my_app.dart';

import 'domain/controllers/authentication/location_controller.dart';
import 'domain/controllers/authentication/storage_controller.dart';
import 'services/locator_service.dart';
import 'domain/use_case/authentication/storage_use_case.dart';

Future<void> main() async {
  //vars for Authentication
  Get.lazyPut<AuthController>(() => AuthController());
  Get.lazyPut<Auth>(() => Auth());

  //vars for Storage
  Get.lazyPut<StorageController>(() => StorageController());
  Get.lazyPut<Storage>(() => Storage());

  // Vars locations
  Loggy.initLoggy(
    logPrinter: const PrettyPrinter(
      showColors: true,
    ),
  );
  
  Get.put(LocatorService());
  Get.put(LocationController());

  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}
