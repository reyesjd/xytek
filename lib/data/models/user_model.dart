class UserModel {
  final String email;
  final String name;
  final int phoneNumber;
  final String user;
  final String password;

  UserModel({
    required this.email,
    required this.name,
    required this.phoneNumber,
    required this.user,
    required this.password,
  });

  Map<String, dynamic> toMap() {
    return {
      'email': email,
      'name': name,
      "phoneNumber": phoneNumber,
      "user": user,
      "password": password
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    assert(map != null);
    return UserModel(
        email: map['email'],
        name: map['name'],
        phoneNumber: map['phoneNumber'],
        user: map['user'],
        password: map["password"]);
  }

  @override
  String toString() {
    return "$email/$name/$password/$phoneNumber/$user";
  }
}
