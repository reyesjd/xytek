import 'package:xytek/data/models/user_model.dart';
import 'package:xytek/services/firebase_store.dart';

class Storage {
  late StoreService storeService;
  Storage() {
    storeService = StoreService();
  }
  Future<void> updateUser(UserModel user) async {
    try {
      storeService.updateUser(user);
    } catch (e) {
      return Future.error(e);
    }
  }
}
