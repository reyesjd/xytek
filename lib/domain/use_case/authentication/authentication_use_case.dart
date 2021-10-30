import 'package:xytek/data/models/user_model.dart';
import 'package:xytek/services/firebase_auth.dart';

class Auth {
  late AuthService authService;

  Auth() {
    authService = AuthService();
  }

  Future<UserModel?> getLoggedUser() async {
    return await authService.getLoggedUser();
  }

  Future<UserModel?> loginEmail(String email, String password) async {
    try {
      UserModel? user = await authService.loginByCredentials(email, password);
      return user;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> signUp(UserModel newUser) async {
    try {
      await authService.signUp(newUser);
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

  Future<void> logingByPhoneNumber({phoneNumber, credential}) async {
    try {
      await authService.logingByPhoneNumber(
          phoneNumber: phoneNumber, credentials: credential);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<UserModel?> verifyCodeSmS(
      {smsCode, verificationId, phoneNumber}) async {
    try {
      UserModel? user = await authService.verifyCodeSmS(
          smsCode: smsCode,
          verificationId: verificationId,
          phoneNumber: phoneNumber);
      return user;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> signOut() async {
    try {
      await authService.signOutFirebase();
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> changeIsSeller() async {
    try {
      UserModel? user = await authService.getLoggedUser();
      print(user.toString());
      if (user == null) {
        return false;
      }
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }
}
