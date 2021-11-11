import 'dart:async';

import 'package:get/get.dart';
import 'package:xytek/data/models/user_model.dart';
import 'package:xytek/domain/use_case/authentication/authentication_use_case.dart';

import 'storage_controller.dart';

class AuthController extends GetxController {
  AuthController() {
    _auth = Get.find();
    storageController = Get.find();
  }

  get userIDLogged => _userIDLogged.value;
  get userModelLogged => _userModelLogged.value;
  get isLogged => _isLogged.value;
  get loadedApp => _loadedApp.value;
  get userModelLoggedOBX => _userModelLogged;
  set setIsLogged(value) => _isLogged.value = value;
  set setUserIDLogged(value) => _userIDLogged.value = value;
  set setUserModelLogged(value) => _userModelLogged = value;
  set setloadedApp(value) => _loadedApp.value = value;

  // General Variables
  var _isLogged = false.obs;
  var _userIDLogged = "".obs;
  late Rx<UserModel?> _userModelLogged = UserModel(
      email: "email",
      name: "name",
      phoneNumber: 12,
      user: "user",
      password: "password",
      isSeller: false).obs;

  // InitialUILoad
  var _loadedApp = false.obs;

  //SignInWithNumber
  var verificationId = "";
  StreamController? credentialPhoneStream;
  var loadingPhone = false.obs;
  String phoneNumber = "";

  //Use Case
  late Auth _auth;
  late StorageController storageController;

  init() async {
    var user = await _auth.getLoggedUser();
    _userModelLogged.value = user;
    print(user);
    if (_userModelLogged.value != null) {
      if (_userModelLogged.value!.uid != null) {
        _userIDLogged.value = _userModelLogged.value!.uid!;
        await storageController.init(_userModelLogged.value);
        print(_userModelLogged.value!.toMap());
      }
    } else {
      _userIDLogged.value = "";
    }
  }

  Future<bool> loginByCredentials(String email, String password) async {
    try {
      UserModel? user = await _auth.loginEmail(email, password);
      if (user != null) {
        _userModelLogged.value = user;
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
        _userModelLogged.value = data as UserModel;
        _userIDLogged.value = _userModelLogged.value!.uid!;
      } else {
        if (data.runtimeType == String) {
          verificationId = data as String;
        }
      }
      actionInStream(data);
    }, onDone: () {}, onError: (error) {});
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
      _userModelLogged.value = user;
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
      _userModelLogged.value = null;
      return true;
    } catch (e) {
      return Future.error(e);
    }
  }
}
