import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xytek/data/models/product_model.dart';
import 'package:xytek/data/models/rating_product_model.dart';
import 'package:xytek/data/models/rating_user_model.dart';
import 'package:xytek/data/models/user_model.dart';

class StoreService {
  late FirebaseFirestore store;

  StoreService() {
    store = FirebaseFirestore.instance;
  }

  Future<void> addproduct(ProductModel product) async {
    try {
      var dicc = product.toMap();

      DocumentReference productF =
          await store.collection('salesProducts').add(dicc);

      DocumentReference userF = store.collection('users').doc(product.uid);

      await userF.update({
        "salesProducts": FieldValue.arrayUnion([productF])
      });

      await store.waitForPendingWrites();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> updateInfoProduct(ProductModel product) async {
    try {
      var dicc = product.toMap();
      var id = product.id;
      await store.collection('salesProducts').doc(id).update(dicc);
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
        if (v.data() != null) {
          Map<String, dynamic> dicc = v.data()!;
          dicc.update("id", (value) => productRefence.id);
          listProducts.add(ProductModel.fromMap(dicc));
        }
      }
      return listProducts;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<RatingProductModel>> getRatingsByProductId(String pid) async {
    try {
      List<RatingProductModel> listRating = [];

      var v = await store
          .collection('ratingsProducts')
          .where('idProduct', isEqualTo: pid)
          .get();

      if (v.docs.isNotEmpty) {
        for (QueryDocumentSnapshot docSnap in v.docs) {
          listRating.add(RatingProductModel.fromMap(docSnap.data()));
        }
      }
      return listRating;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> addRatingProduct(RatingProductModel rating) async {
    try {
      var dicc = rating.toMap();

      await store.collection('ratingsProducts').add(dicc);

      await store.waitForPendingWrites();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<RatingUserModel>> getRatingsByUserId(String uid) async {
    try {
      List<RatingUserModel> listRating = [];

      var v = await store
          .collection('ratingsUser')
          .where('idUser', isEqualTo: uid)
          .get();

      if (v.docs.isNotEmpty) {
        for (QueryDocumentSnapshot docSnap in v.docs) {
          listRating.add(RatingUserModel.fromMap(docSnap.data()));
        }
      }
      return listRating;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> addRatingUser(RatingUserModel rating) async {
    try {
      var dicc = rating.toMap();

      await store.collection('ratingsUser').add(dicc);

      await store.waitForPendingWrites();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<ProductModel>> getallProducts() async {
    try {
      List<ProductModel> listProducts = [];

      var v = await store.collection('salesProducts').get();
      print("todos los productos");
      print(v);
      if (v.docs.isNotEmpty) {
        for (QueryDocumentSnapshot docSnap in v.docs) {
          print(docSnap.data());
          listProducts.add(ProductModel.fromMap(docSnap.data()));
        }
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

  Future<void> updateUser(map) async {
    try {
      await store.collection('users').doc(map["uid"]).update(map);
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
