import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class SellerStatistics extends StatelessWidget {
  SellerStatistics({Key? key}) : super(key: key) {
    seller = Get.arguments;
  }
  late Map<String, dynamic> seller;
  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
