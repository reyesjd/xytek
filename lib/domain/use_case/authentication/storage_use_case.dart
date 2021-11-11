import 'package:xytek/data/models/product_model.dart';
import 'package:xytek/data/models/user_model.dart';
import 'package:xytek/services/firebase_store.dart';

class Storage {
  late StoreService storeService;
  Storage() {
    storeService = StoreService();
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
      if (salesProductsReferences!=null) {
        map.addAll({"salesProducts": salesProductsReferences});
      }

      storeService.updateUser(map);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> addNewProduct(ProductModel newProduct) async {
    try {
      await storeService.addproduct(newProduct);
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
}
