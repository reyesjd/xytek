import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xytek/data/models/product_model.dart';
import 'package:xytek/data/models/rating_product_model.dart';
import 'package:xytek/data/models/rating_user_model.dart';
import 'package:xytek/data/models/purchase_model.dart';
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
      await productF.update({"id": productF.id});
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
          var data = docSnap.data();
          if (data["id"] != null) {
            listRating.add(RatingProductModel.fromMap(data));
          }
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
          .where('idSeller', isEqualTo: uid)
          .get();

      if (v.docs.isNotEmpty) {
        for (QueryDocumentSnapshot docSnap in v.docs) {
          var data = docSnap.data();
          if (data["id"] != null) {
            listRating.add(RatingUserModel.fromMap(data));
          }
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

  Future<ProductModel?> getProductById(pid) async {
    try {
      ProductModel? product;

      var v = await store
          .collection("salesProducts")
          .where('id', isEqualTo: pid)
          .get();

      if (v.docs.isNotEmpty) {
        for (QueryDocumentSnapshot docSnap in v.docs) {
          product = ProductModel.fromMap(docSnap.data());
        }
      }
      return product;
    } catch (e) {
      return null;
    }
  }

  Future<List<ProductModel>> getallProducts(
      {category = "", searchedName = "", required shopperId}) async {
    try {
      List<ProductModel> listProducts = [];
      QuerySnapshot v;
      if (searchedName == "") {
        if (category == "") {
          v = await store
              .collection('salesProducts')
              .where('uid', isNotEqualTo: shopperId)
              .get();
        } else {
          v = await store
              .collection('salesProducts')
              .where('uid', isNotEqualTo: shopperId)
              .where('category', isEqualTo: category)
              .get();
        }
      } else {
        if (category == "") {
          v = await store
              .collection('salesProducts')
              .where('uid', isNotEqualTo: shopperId)
              .where('name', isGreaterThanOrEqualTo: searchedName)
              .get();
        } else {
          v = await store
              .collection('salesProducts')
              .where('uid', isNotEqualTo: shopperId)
              .where('name', isGreaterThanOrEqualTo: searchedName)
              .where('category', isEqualTo: category)
              .get();
        }
      }

      if (v.docs.isNotEmpty) {
        for (QueryDocumentSnapshot docSnap in v.docs) {
          var data = docSnap.data();
          if (data["id"] != null) {
            listProducts.add(ProductModel.fromMap(data));
          }
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

  Future<void> addPurchase(PurchaseModel purchase) async {
    try {
      var dicc = purchase.toMap();

      DocumentReference purchaseF =
          await store.collection('purchasedProducts').add(dicc);
      await purchaseF.update({"id": purchaseF.id});
      await store.waitForPendingWrites();
    } catch (e) {
      Future.error(e);
    }
  }

  Future<List<Map<String, dynamic>>> getPurchaseByShopperId(
      {required uid, category = ""}) async {
    try {
      List<Map<String, dynamic>> list = [];

      var v;
      if (category == "") {
        v = await store
            .collection('purchasedProducts')
            .where('uidShopper', isEqualTo: uid)
            .get();
      } else {
        v = await store
            .collection('purchasedProducts')
            .where('uidShopper', isEqualTo: uid)
            .where('category', isEqualTo: category)
            .get();
      }

      if (v.docs.isNotEmpty) {
        print("hola");
        for (QueryDocumentSnapshot docSnap in v.docs) {
          var data = docSnap.data();
          if (data["id"] != null) {
            PurchaseModel purchase = PurchaseModel.fromMap(data);
            ProductModel? product = await getProductById(purchase.productId);
            if (product != null) {
              Map<String, dynamic> purchaseInfo = {
                "purchase": purchase,
                "product": product
              };
              list.add(purchaseInfo);
            }
          }
        }
      }
      print(list);
      return list;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<Map<String, dynamic>>> getPurchaseBySellerId(
      {required uid, category = ""}) async {
    try {
      List<Map<String, dynamic>> list = [];

      QuerySnapshot v;
      if (category == "") {
        v = await store
            .collection('purchasedProducts')
            .where('uidSeller', isEqualTo: uid)
            .get();
      } else {
        v = await store
            .collection('purchasedProducts')
            .where('uidSeller', isEqualTo: uid)
            .where('category', isEqualTo: category)
            .get();
      }

      if (v.docs.isNotEmpty) {
        print("hola");
        for (QueryDocumentSnapshot docSnap in v.docs) {
          var data = docSnap.data();
          if (data["id"] != null) {
            PurchaseModel purchase = PurchaseModel.fromMap(data);
            ProductModel? product = await getProductById(purchase.productId);
            if (product != null) {
              Map<String, dynamic> purchaseInfo = {
                "purchase": purchase,
                "product": product
              };
              list.add(purchaseInfo);
            }
          }
        }
      }
      print(list);
      return list;
    } catch (e) {
      return Future.error(e);
    }
  }
}
