class UserModel {
  final String email;
  final String name;
  final int phoneNumber;
  final String user;
  final String password;
  final String? uid;

  UserModel(
      {required this.email,
      required this.name,
      required this.phoneNumber,
      required this.user,
      required this.password,
      this.uid});

  Map<String, dynamic> toMap(bool withUserID) {
    if (withUserID) {
      return {
        'email': email,
        'name': name,
        "phoneNumber": phoneNumber,
        "user": user,
        "password": password,
        "uid":uid
      };
    } else {
      return {
        'email': email,
        'name': name,
        "phoneNumber": phoneNumber,
        "user": user,
        "password": password,
      };
    }
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
        email: map['email'],
        name: map['name'],
        phoneNumber: map['phoneNumber'],
        user: map['user'],
        password: map["password"],
        uid: map["uid"]);
  }

  @override
  String toString() {
    return "$email/$name/$password/$phoneNumber/$user";
  }
}
