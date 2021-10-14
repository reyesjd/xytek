import 'package:firebase_auth/firebase_auth.dart';
import 'package:xytek/services/firebase_auth.dart';

class Auth {
  late AuthService authService;

  Auth() {
    authService = AuthService();
  }

  Future<User?> loginEmail(String email, String password) async {
    try {
      var user = await authService.loginByCredentials(email, password);
      return user;
    } catch (error) {
      print(error);
    }
  }

  Future<User?> signUp({email, password}) async {
    var user = await authService.signUp(email: email, password: password);
    return user;
  }
}
