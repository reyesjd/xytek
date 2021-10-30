import 'dart:async';

import 'package:get/get.dart';
import 'package:xytek/data/models/user_model.dart';
import 'package:xytek/domain/use_case/authentication/authentication_use_case.dart';

class AuthController extends GetxController {
  AuthController() {
    init();
  }

  get userIDLogged => _userIDLogged.value;
  get userModelLogged => _userModelLogged;
  get isLogged => _isLogged.value;
  get loadedApp => _loadedApp.value;

  set setIsLogged(value) => _isLogged.value = value;
  set setUserIDLogged(value) => _userIDLogged.value = value;
  set setUserModelLogged(value) => _userModelLogged = value;
  set setloadedApp(value) => _loadedApp.value = value;

  // General Variables
  var _isLogged = false.obs;
  var _userIDLogged = "".obs;
  var _userModelLogged;

  // InitialUILoad
  var _loadedApp = false.obs;

  //SignInWithNumber
  var verificationId = "";
  StreamController? credentialPhoneStream;
  var loadingPhone = false.obs;
  String phoneNumber = "";

  //Use Case
  final Auth _auth = Get.find();

  init() async {
    _userModelLogged = await _auth.getLoggedUser();
    if (_userModelLogged != null) {
      _userIDLogged.value = _userModelLogged.uid;
    } else {
      _userIDLogged.value = "";
    }
  }

  Future<bool> loginByCredentials(String email, String password) async {
    try {
      UserModel? user = await _auth.loginEmail(email, password);
      if (user != null) {
        _userModelLogged = user;
        _userIDLogged.value = user.uid!;
      }
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> signUp(UserModel newUser) async {
    try {
      await _auth.signUp(newUser);
      return true;
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

  Future<void> logingByPhoneNumber({phoneNumber, actionInStream}) async {
    credentialPhoneStream = StreamController();
    credentialPhoneStream?.stream.listen((data) {
      if (data.runtimeType == UserModel) {
        _userModelLogged = data as UserModel;
        _userIDLogged.value = _userModelLogged.uid;
      } else {
        if (data.runtimeType == String) {
          verificationId = data as String;
        }
      }
      actionInStream(data);
    }, onDone: () {
      print("Task Done");
    }, onError: (error) {
      print("Some Error");
    });
    try {
      await _auth.logingByPhoneNumber(
          phoneNumber: phoneNumber, credential: credentialPhoneStream);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> verifyCodeSmS({smsCode, phoneNumber}) async {
    try {
      UserModel? user = await _auth.verifyCodeSmS(
          smsCode: smsCode,
          verificationId: verificationId,
          phoneNumber: phoneNumber);
      _userModelLogged = user;
      _userIDLogged.value = user!.uid!;
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> signOut() async {
    try {
      await _auth.signOut();
      _userIDLogged.value = "";
      _userModelLogged = null;
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<bool> updateIsSeller() async {
    try {
      return await _auth.changeIsSeller();
    } catch (e) {
      return Future.error(e);
    }
  }
}
