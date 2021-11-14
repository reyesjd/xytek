import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xytek/data/models/product_model.dart';
import 'package:xytek/data/models/rating_product_model.dart';
import 'package:xytek/data/models/rating_user_model.dart';
import 'package:xytek/data/models/user_model.dart';
import 'package:xytek/domain/use_case/authentication/storage_use_case.dart';

class StorageController extends GetxController {
  late Storage storage;
  late DateFormat format;
  StorageController() {
    storage = Get.find();
    salesProductsModels = [].obs;
    mainProductsModels = [].obs;
    format = DateFormat('yyyy-MM-dd');
  }

  late RxList salesProductsModels;
  late RxList mainProductsModels;

  init(UserModel? user) async {
    if (user != null) {
      salesProductsModels.value = await getInfoSalesProducts(user.uid!);
      await getallProducts();
    }
  }

  Future<void> updateUser(
      {required uid,
      email,
      name,
      phoneNumber,
      user,
      password,
      isSeller,
      coordinates,
      salesProductsReferences}) async {
    try {
      await storage.updateUser(
          email: email,
          name: name,
          phoneNumber: phoneNumber,
          user: user,
          uid: uid,
          password: password,
          isSeller: isSeller,
          coordinates: coordinates,
          salesProductsReferences: salesProductsReferences);
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

  Future<void> getallProducts() async {
    try {
      List<ProductModel> list = await storage.getallProducts();
      mainProductsModels.value = list;
    } catch (e) {
      return Future.error(e);
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

  Future<void> addNewCommentProduct(
      {required name,
      required urlImage,
      required idShopperUser,
      required idProduct,
      required rating,
      required comment}) async {
    try {
      DateTime newDate = DateTime.now();
      String date = format.format(newDate);

      RatingProductModel newComment = RatingProductModel(
          date: date,
          idProduct: idProduct,
          idShopperUser: idShopperUser,
          name: name,
          rating: rating,
          urlImage: urlImage,
          comment: comment);
      print(newComment.toMap());

      await storage.addNewRatingProduct(newComment);
    } catch (e) {
      Future.error(e);
    }
  }

  Future<void> addNewCommentUser(
      {required name,
      required urlImage,
      required idShopperUser,
      required idUser,
      required rating,
      required comment}) async {
    try {
      DateTime newDate = DateTime.now();
      String date = format.format(newDate);

      RatingUserModel newComment = RatingUserModel(
          name: name,
          urlImage: urlImage,
          idShopperUser: idShopperUser,
          idUser: idUser,
          rating: rating,
          date: date,
          comment: comment);

      await storage.addNewRatingUser(newComment);
    } catch (e) {
      Future.error(e);
    }
  }

  Future<List<RatingProductModel>> getProductsRating(String pid) async {
    try {
      List<RatingProductModel> list = await storage.getProductsRating(pid);
      return Future.value(list);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<UserModel?> getUserById(uid) async {
    return await storage.getUserById(uid);
  }
}
