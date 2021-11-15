import 'package:xytek/data/models/product_model.dart';
import 'package:xytek/data/models/rating_product_model.dart';
import 'package:xytek/data/models/rating_user_model.dart';
import 'package:xytek/data/models/user_model.dart';
import 'package:xytek/services/firebase_store.dart';

class Storage {
  late StoreService storeService;
  Storage() {
    storeService = StoreService();
  }

  Future<UserModel?> getUserById(String uid) async {
    UserModel? user =
        await storeService.getInformationUserByUserID(userId: uid);
    return user;
  }

  Future<void> addNewProduct(ProductModel newProduct) async {
    try {
      await storeService.addproduct(newProduct);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<ProductModel>> getallProducts(
      {category = "", searchedName = ""}) async {
    try {
      List<ProductModel> list = await storeService.getallProducts(
          category: category, searchedName: searchedName);
      return Future.value(list);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<ProductModel?> getLastSalesProduct(String uid) async {
    try {
      List<ProductModel> products =
          await storeService.getInfoSalesProductsUser(uid);
      if (products.isEmpty) {
        return null;
      } else {
        return products.last;
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> updateInfoProduct(ProductModel newProduct) async {
    try {
      await storeService.updateInfoProduct(newProduct);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<ProductModel>> getInfoSalesProducts(String uid) async {
    try {
      List<ProductModel> products =
          await storeService.getInfoSalesProductsUser(uid);
      return products;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> addNewRatingProduct(RatingProductModel rating) async {
    try {
      await storeService.addRatingProduct(rating);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> addNewRatingUser(RatingUserModel rating) async {
    try {
      await storeService.addRatingUser(rating);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<RatingProductModel>> getProductsRating(String pid) async {
    try {
      List<RatingProductModel> list =
          await storeService.getRatingsByProductId(pid);
      return Future.value(list);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<List<RatingUserModel>> getUserRating(String uid) async {
    try {
      List<RatingUserModel> list = await storeService.getRatingsByUserId(uid);
      return Future.value(list);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> updateUser(
      {email,
      name,
      phoneNumber,
      user,
      required uid,
      password,
      isSeller,
      coordinates,
      salesProductsReferences}) async {
    try {
      Map<String, dynamic> map = {};
      map.addAll({"uid": uid});
      if (email != null) {
        map.addAll({"email": email});
      }
      if (name != null) {
        map.addAll({"name": name});
      }
      if (phoneNumber != null) {
        map.addAll({"phoneNumber": phoneNumber});
      }
      if (user != null) {
        map.addAll({"user": user});
      }
      if (coordinates != null) {
        map.addAll({"coordinates": coordinates});
      }
      if (isSeller != null) {
        map.addAll({"isSeller": isSeller});
      }
      if (salesProductsReferences != null) {
        map.addAll({"salesProducts": salesProductsReferences});
      }

      storeService.updateUser(map);
    } catch (e) {
      return Future.error(e);
    }
  }
}
