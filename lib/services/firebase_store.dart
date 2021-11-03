import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xytek/data/models/product_model.dart';
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

  Future<void> updateInfoProduct(ProductModel product)async {
    try {
      var dicc = product.toMap();
      var id = product.id;
      await store.collection('salesProducts').doc(id).update(dicc);
      await store.waitForPendingWrites();
    } catch (e) {
      return Future.error(e);
    }
  }

  

  Future<void> addproduct(ProductModel product) async {
    try {
      var dicc = product.toMap();
      var id = product.id;
      DocumentReference productF = store.collection('salesProducts').doc(id);
      await productF.set(dicc);

      DocumentReference userF = store.collection('users').doc(product.uid);

      await userF.update({
        "salesProducts": FieldValue.arrayUnion([productF])
      });
      await store.waitForPendingWrites();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<ProductModel>> getInfoSalesProductsUser(String uid) async {
    try {
      List<ProductModel> listProducts = [];
      DocumentReference userF = store.collection('users').doc(uid);
      var info = await userF.get();
      List list = info.get("salesProducts");
      for (DocumentReference productRefence in list) {
        var v = await productRefence.get();
        listProducts.add(ProductModel.fromMap(v.data()));
      }
      return listProducts;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> addUser(UserModel newUserModel, User newUserFirebase) async {
    try {
      User user = newUserFirebase;
      var dicc = newUserModel.toMap();
      var uid = user.uid;
      dicc.addAll({"uid": uid});
      await store.collection('users').doc(uid).set(dicc);
      await store.waitForPendingWrites();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<UserModel?> getInformationUserByUserID({userId}) async {
    try {
      var infoUser = await store.collection('users').doc(userId).get();
      var dicc = infoUser.data();
      if (dicc!.isNotEmpty) {
        UserModel? user = UserModel.fromMap(dicc);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> getInformationUserByPhoneNumber({phoneNumber}) async {
    try {
      var infoUser = store
          .collection('users')
          .where("phoneNumber", isEqualTo: phoneNumber);
      var result = await infoUser.get();
      var dicc = result.docs.first.data();
      if (dicc.isNotEmpty) {
        return UserModel.fromMap(result.docs.first.data());
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }
}
