import 'package:firebase_auth/firebase_auth.dart';
import 'package:xytek/services/firebase_auth.dart';

class Auth {
  final FirebaseAuth auth = FirebaseAuth.instance;

  Future<User?> loginEmail(String email, String password) async {
    try {
      User user = await loginByCredentials(email, password);
      return user;
    } catch (error) {
      print(error);
    }
  }

  Future<User> handleSignUp(email, password) async {
    UserCredential result = await auth.createUserWithEmailAndPassword(
        email: email, password: password);
    final User user = result.user!;

    return user;
  }
}
