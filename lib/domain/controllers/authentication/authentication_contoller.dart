import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:xytek/data/models/user_model.dart';
import 'package:xytek/domain/use_case/authentication/authentication_use_case.dart';

class AuthController extends GetxController {
  var _isLogged = false.obs;
  var _userModel;

  Auth _auth = Auth();

  Future<bool> loginByCredentials(String email, String password) async {
    User? user = await _auth.loginEmail(email, password);
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }

  Future<bool> signUp(UserModel newUser) async {
    User? user =
        await _auth.signUp(email: newUser.email, password: newUser.password);
    if (user != null) {
      return true;
    } else {
      return false;
    }
  }
}
