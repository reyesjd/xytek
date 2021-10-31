import 'package:get/get.dart';
import 'package:xytek/data/models/user_model.dart';
import 'package:xytek/domain/use_case/authentication/storage_use_case.dart';

class StorageController extends GetxController {
  late Storage storage = Get.find();

  Future<void> updateUser(UserModel user) async {
    try {
      await storage.updateUser(user);
    } catch (e) {
      return Future.error(e);
    }
  }
}
