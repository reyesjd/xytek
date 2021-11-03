import 'package:get/get.dart';
import 'package:xytek/data/models/product_model.dart';
import 'package:xytek/data/models/user_model.dart';
import 'package:xytek/domain/use_case/authentication/storage_use_case.dart';

class StorageController extends GetxController {
  late Storage storage;
  StorageController() {
    storage = Get.find();
  }

  Future<void> updateUser(UserModel user) async {
    try {
      await storage.updateUser(user);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> addNewProduct(
      {required name,
      required category,
      required description,
      required price,
      required urlImage,
      required uid}) async {
    try {
      ProductModel? lastProduct = await storage.getLastSalesProduct(uid);
      int id = 0;
      if (lastProduct != null) {
        String lastId = lastProduct.id;
        String subId = lastId.replaceAll(uid, "");
        int lastNumId = int.parse(subId);
        id = lastNumId + 1;
      }
      String newId = uid + "$id";
      ProductModel newProduct = ProductModel(
          name: name,
          category: category,
          description: description,
          price: price,
          urlImage: urlImage,
          id: newId,
          uid: uid);

      await storage.addNewProduct(newProduct);
    } catch (e) {
      Future.error(e);
    }
  }

  Future<void> updateInfoProduct(
      {required name,
      required category,
      required description,
      required price,
      required urlImage,
      required uid,
      required id}) async {
    try {
      ProductModel newProduct = ProductModel(
          name: name,
          category: category,
          description: description,
          price: price,
          urlImage: urlImage,
          id: id,
          uid: uid);

      await storage.updateInfoProduct(newProduct);
    } catch (e) {
      Future.error(e);
    }
  }

  Future<List<ProductModel>> getInfoSalesProducts(String uid) async {
    try {
      List<ProductModel> products = await storage.getInfoSalesProducts(uid);
      return products;
    } catch (e) {
      return Future.error(e);
    }
  }
}
