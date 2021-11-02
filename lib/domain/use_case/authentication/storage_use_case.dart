import 'package:xytek/data/models/product_model.dart';
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
          await storeService.getInfoSaleProductsUser(uid);
      print(products);
      if (products.isEmpty) {
        return null;
      } else {
        return products.last;
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
