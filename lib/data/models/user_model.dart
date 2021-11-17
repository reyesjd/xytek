import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:xytek/data/models/locations_model.dart';

class UserModel {
  String email;
  String name;
  int phoneNumber;
  String user;
  String? uid;
  String password;
  bool isSeller;
  String urlProfile;
  //latitud,length
  List? locationsModel;
  List? salesProductsReferences;

  UserModel(
      {required this.email,
      required this.name,
      required this.phoneNumber,
      required this.user,
      this.uid,
      required this.password,
      required this.isSeller,
      this.locationsModel,
      this.salesProductsReferences,
      this.urlProfile =
          "https://i1.sndcdn.com/avatars-000396582750-afqhbt-t240x240.jpg"});

  void addSaleProductReference(DocumentReference productReference) {
    if (salesProductsReferences != null) {
      salesProductsReferences?.add(productReference);
    }
  }

  update({email, name, phoneNumber, user, locationsModel}) {
    if (email != null) {
      this.email = email;
    }
    if (name != null) {
      this.name = name;
    }
    if (phoneNumber != null) {
      this.phoneNumber = int.parse(phoneNumber);
    }
    if (user != null) {
      this.user = user;
    }
    if (locationsModel != null) {
      this.locationsModel = locationsModel;
    }
  }

  Map<String, dynamic> toMap() {
    return {
      "locationsModel": locationsModel?.map((e) => e.toMap()).toList(),
      'email': email,
      'name': name,
      "phoneNumber": phoneNumber,
      "user": user,
      "uid": uid,
      "password": password,
      "isSeller": isSeller,
      "salesProducts": salesProductsReferences,
      "urlProfile": urlProfile
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
        locationsModel: map?["locationsModel"]?.map((value) {
          return LocationsModel.fromMap(value);
        }).toList(),
        salesProductsReferences: map?["salesProducts"],
        urlProfile: map?["urlProfile"]);
  }
}
