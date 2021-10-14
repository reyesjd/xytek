import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/ui/my_app.dart';

void main() {
  Get.lazyPut<AuthController>(() => AuthController());
  runApp(MyApp());
}
