import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:xytek/data/models/product_model.dart';
import 'package:xytek/data/models/purchase_model.dart';
import 'package:xytek/data/models/rating_product_model.dart';
import 'package:xytek/data/models/rating_user_model.dart';
import 'package:xytek/data/models/user_model.dart';
import 'package:xytek/domain/controllers/authentication/authentication_contoller.dart';
import 'package:xytek/domain/use_case/authentication/storage_use_case.dart';

class StorageController extends GetxController {
  late Storage storage;
  late DateFormat format;
  StorageController() {
    storage = Get.find();
    salesProductsModels = [].obs;
    mainProductsModels = [].obs;
    cartProductsModels = [].obs;
    format = DateFormat('yyyy-MM-dd');
  }

  late RxList salesProductsModels;
  late RxList mainProductsModels;
  late RxList cartProductsModels;

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
      locationsModel,
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
          locationsModel: locationsModel,
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
      required user,
      required amountAvalaible}) async {
    try {
      ProductModel newProduct = ProductModel(
          name: name,
          category: category,
          description: description,
          price: price,
          urlImage: urlImage,
          id: "",
          uid: user.uid,
          amountAvalaible: amountAvalaible);
      await storage.addNewProduct(newProduct);

      salesProductsModels.add(newProduct);
    } catch (e) {
      Future.error(e);
    }
  }

  Future<void> getallProducts({category = "", searchedName = ""}) async {
    try {
      List<ProductModel> list = await storage.getallProducts(
          category: category, searchedName: searchedName);
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
      required id,
      required amountAvalaible}) async {
    try {
      ProductModel newProduct = ProductModel(
          name: name,
          category: category,
          description: description,
          price: price,
          urlImage: urlImage,
          id: id,
          uid: uid,
          amountAvalaible: amountAvalaible);

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
      required comment,
      listCommentsOBX}) async {
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
      if (listCommentsOBX != null) {
        listCommentsOBX.add(newComment);
      }
    } catch (e) {
      Future.error(e);
    }
  }

  Future<void> addNewCommentUser(
      {required name,
      required urlImage,
      required idShopperUser,
      required idSeller,
      required rating,
      required comment,
      listCommentsOBX}) async {
    try {
      DateTime newDate = DateTime.now();
      String date = format.format(newDate);

      RatingUserModel newComment = RatingUserModel(
          name: name,
          urlImage: urlImage,
          idShopperUser: idShopperUser,
          idSeller: idSeller,
          rating: rating,
          date: date,
          comment: comment);

      await storage.addNewRatingUser(newComment);
      if (listCommentsOBX != null) {
        listCommentsOBX.add(newComment);
      }
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

  Future<List<RatingUserModel>> getUserRatings(String uid) async {
    try {
      List<RatingUserModel> list = await storage.getUserRating(uid);
      return Future.value(list);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<UserModel?> getUserById(uid) async {
    return await storage.getUserById(uid);
  }

  Future<List> getInfoSellerAndRating({product}) async {
    UserModel? user = await storage.getUserById(product["uid"]);
    List<RatingUserModel> list = await getUserRatings(product["uid"]);
    return [user, list];
  }

  double getAverageSellerRating(List<RatingUserModel> list) {
    if (list.isEmpty) {
      return 0;
    } else {
      double sum = 0;
      for (RatingUserModel rating in list) {
        sum = sum + rating.rating;
      }
      return sum / list.length;
    }
  }

  Future<double> getSellerAverage({uid}) async {
    List<RatingUserModel> list = await getUserRatings(uid);

    if (list.isEmpty) {
      return Future.value(0);
    } else {
      double sum = 0;
      for (RatingUserModel rating in list) {
        sum = sum + rating.rating;
      }

      return Future.value(sum / list.length);
    }
  }

  Future<void> addPurchase({required payment, required shopperId}) async {
    try {
      DateTime newDate = DateTime.now();
      String date = format.format(newDate);
      PurchaseModel purchase;
      for (Map map in cartProductsModels) {
        purchase = PurchaseModel(
            uidShopper: shopperId,
            date: date,
            paymentMethod: payment,
            productId: map["id"],
            uidSeller: map["uid"],
            quantity: map["quantity"].value,
            category: map["category"]);
        await storage.addPurchase(purchase);
      }
    } catch (e) {
      Future.error(e);
    }
  }

  Future<List<Map<String, dynamic>>> getPurchases(
      {category = "",
      shopperId = "",
      sellerId = "",
      required isShopper}) async {
    try {
      if (isShopper) {
        List<Map<String, dynamic>> list = await storage.getPurchaseByShopperId(
            uid: shopperId, category: category);
        return Future.value(list);
      } else {
        List<Map<String, dynamic>> list = await storage.getPurchaseBySellerId(
            uid: sellerId, category: category);
        return Future.value(list);
      }
    } catch (e) {
      return Future.error(e);
    }
  }
}
