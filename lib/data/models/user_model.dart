class UserModel {
  final String email;
  final String name;
  final String uid;

  UserModel({
    required this.email,
    required this.name,
    required this.uid,
  });

  Map<String, dynamic> toMap() {
    return {'email': email, 'name': name};
  }

  factory UserModel.fromMap(String uid, Map<String, dynamic> map) {
    assert(map != null);
    return UserModel(
      email: map['email'],
      name: map['name'],
      uid: uid,
    );
  }
}
