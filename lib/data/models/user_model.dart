class UserModel {
  final String email;
  final String name;
  final int phoneNumber;
  final String user;
  final String? uid;
  final String password;
  final bool isSeller;
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
      required this.isSeller});

  Map<String, dynamic> toMap({bool withUserID = true}) {
    if (withUserID) {
      return {
        'email': email,
        'name': name,
        "phoneNumber": phoneNumber,
        "user": user,
        "uid": uid,
        "password": password,
        "isSeller": isSeller,
      };
    } else {
      return {
        'email': email,
        'name': name,
        "phoneNumber": phoneNumber,
        "user": user,
        "password": password,
        "isSeller": isSeller,
      };
    }
  }

  factory UserModel.fromMap(Map<String, dynamic>? map) {
    return UserModel(
        email: map?['email'],
        name: map?['name'],
        phoneNumber: map?['phoneNumber'],
        user: map?['user'],
        password: map?["password"],
        uid: map?["uid"],
        isSeller: map?["isSeller"]);
  }

  @override
  String toString() {
    return "$email/$name/$password/$phoneNumber/$user/$isSeller";
  }
}
