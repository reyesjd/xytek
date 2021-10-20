import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:xytek/data/models/user_model.dart';
import 'package:xytek/domain/use_case/authentication/authentication_use_case.dart';

class AuthController extends GetxController {
  var _isLogged = false.obs;
  var _userModel;

  final Auth _auth = Get.find();

  Future<UserModel> loginByCredentials(String email, String password) async {
    try {
      UserModel user = await _auth.loginEmail(email, password);
      _userModel = user;
      return user;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> signUp(UserModel newUser) async {
    try {
      User? user =
          await _auth.signUp(email: newUser.email, password: newUser.password);
      if (user != null) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> resetPassword({email}) async {
    try {
      bool val = await _auth.resetPassword(email: email);
      return val;
    } catch (e) {
      return Future.error(e);
    }
  }
}
