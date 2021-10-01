import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:xytek/common/constants.dart';
import 'package:xytek/ui/pages/launc_page.dart';
import 'package:xytek/ui/pages/login/login_main_page.dart';

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'News App',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Roboto'),
      initialRoute: HOME_ROUTE,
      getPages: [
        GetPage(name: HOME_ROUTE, page: () => LoginMainPage()),
      ],
    );
  }
}
