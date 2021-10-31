import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xytek/data/models/user_model.dart';

class StoreService {
  late FirebaseFirestore store;

  StoreService() {
    store = FirebaseFirestore.instance;
  }

  Future<void> updateUser(UserModel user) async {
    try {
      var dicc = user.toMap();
      var uid = user.uid;
      await store.collection('users').doc(uid).update(dicc);
      await store.waitForPendingWrites();
    } catch (e) {
      return Future.error(e);
    }
  }
}
