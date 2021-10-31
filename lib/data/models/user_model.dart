import 'package:xytek/data/models/product_model.dart';

class UserModel {
  String email;
  String name;
  int phoneNumber;
  String user;
  String? uid;
  String password;
  bool isSeller;
  //latitud,length
  String? coordinates;
  List<ProductModel>? saleProducts;

  /*
  final String identification;
  final String? linkPhoto;
  final List shoppingCar;
  final List productsSale;
  final 
  */

  UserModel(
      {required this.email,
      required this.name,
      required this.phoneNumber,
      required this.user,
      this.uid,
      required this.password,
      required this.isSeller,
      this.coordinates,
      this.saleProducts});

  Map<String, dynamic> toMap() {
    return {
      "coordinates": coordinates,
      'email': email,
      'name': name,
      "phoneNumber": phoneNumber,
      "user": user,
      "uid": uid,
      "password": password,
      "isSeller": isSeller,
      "saleProducts": saleProducts
    };
  }

  factory UserModel.fromMap(Map<String, dynamic>? map) {
    return UserModel(
        email: map?['email'],
        name: map?['name'],
        phoneNumber: map?['phoneNumber'],
        user: map?['user'],
        password: map?["password"],
        uid: map?["uid"],
        isSeller: map?["isSeller"],
        coordinates: map?["coordinates"],
        saleProducts: map?["saleProducts"]);
  }

  @override
  String toString() {
    return "$email/$name/$password/$phoneNumber/$user/$isSeller";
  }
}
