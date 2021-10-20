import 'package:firebase_auth/firebase_auth.dart';
import 'package:xytek/data/models/user_model.dart';
import 'package:xytek/services/firebase_auth.dart';

class Auth {
  late AuthService authService;

  Auth() {
    authService = AuthService();
  }

  Future<UserModel> loginEmail(String email, String password) async {
    try {
      //var fireUser = 
      await authService.loginByCredentials(email, password);
      UserModel user = UserModel(
          email: email,
          name: "name",
          phoneNumber: 1234567,
          user: "user",
          password: password,
          uid:"uid");
      return user;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<User?> signUp({email, password}) async {
    try {
      var user = await authService.signUp(email: email, password: password);
      return user;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> resetPassword({email}) async {
    try {
      var val = await authService.resetPassword(email: email);
      return val;
    } catch (e) {
      return Future.error(e);
    }
  }
}
