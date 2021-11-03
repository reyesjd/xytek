
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
  List? salesProductsReferences;
  //Lista para almaenar en el sistema los modelos de los productos 
  List? salesProductsModels;

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
      this.salesProductsReferences});

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
      "salesProducts": salesProductsReferences,
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
        salesProductsReferences: map?["salesProducts"]);
  }
/*
  @override
  String toString() {
    return toMap().toString();
  }*/
}
