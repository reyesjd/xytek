import 'package:get/get.dart';
import 'package:xytek/data/models/product_model.dart';
import 'package:xytek/data/models/user_model.dart';
import 'package:xytek/domain/use_case/authentication/storage_use_case.dart';

class StorageController extends GetxController {
  late Storage storage;
  StorageController() {
    storage = Get.find();
    salesProductsModels = [].obs;
  }
  late RxList salesProductsModels;

  init(UserModel? user) async {
    if (user != null) {
      salesProductsModels.value = await getInfoSalesProducts(user.uid!);
    }
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
      required user}) async {
    try {
      ProductModel newProduct = ProductModel(
          name: name,
          category: category,
          description: description,
          price: price,
          urlImage: urlImage,
          id: "",
          uid: user.uid);
      await storage.addNewProduct(newProduct);
      
      salesProductsModels.add(newProduct);
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
