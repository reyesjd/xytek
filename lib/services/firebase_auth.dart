import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xytek/data/models/user_model.dart';
import 'package:xytek/services/firebase_store.dart';

class AuthService {
  late FirebaseAuth auth;
  late StoreService storeService;

  AuthService() {
    auth = FirebaseAuth.instance;
    storeService = StoreService();
  }

  Future<UserModel?> getLoggedUser() async {
    if (auth.currentUser != null) {
      try {
        if (auth.currentUser!.phoneNumber != null) {
          if (auth.currentUser!.phoneNumber!.isNotEmpty) {
            String colPhoneNumber = auth.currentUser!.phoneNumber!.substring(3);
            UserModel? user =
                await storeService.getInformationUserByPhoneNumber(
                    phoneNumber: int.parse(colPhoneNumber));
            return user;
          }
        }
        print(auth.currentUser);
        UserModel? user = await storeService.getInformationUserByUserID(
            userId: auth.currentUser!.uid);
        return user;
      } catch (e) {
        return null;
      }
    }
  }

  Future<UserModel?> loginByCredentials(String email, String password) async {
    User user;
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = result.user!;

      return storeService.getInformationUserByUserID(userId: user.uid);
    } on FirebaseAuthException catch (e) {
      return Future.error(e.code);
    }
  }

  Future<void> logingByPhoneNumber({phoneNumber, credentials}) async {
    try {
      UserModel? user = await storeService.getInformationUserByPhoneNumber(
          phoneNumber: int.parse(phoneNumber));
      if (user != null) {
        await auth.verifyPhoneNumber(
          timeout: const Duration(seconds: 30),
          verificationCompleted: (PhoneAuthCredential credential) async {
            await auth.signInWithCredential(credential);
            credentials.add(user);
          },
          verificationFailed: (FirebaseAuthException e) {
            credentials.add("Error: " + e.code);
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            //credentials.add(verificationId);
          },
          phoneNumber: "+57 " + phoneNumber,
          codeSent: (String verificationId, int? resendToken) async {
            credentials.add(verificationId);
          },
        );
      } else {
        credentials.add("Error: Number phone no registered");
      }
    } on FirebaseAuthException catch (e) {
      return Future.error(e.code);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<UserModel?> verifyCodeSmS(
      {verificationId, smsCode, phoneNumber}) async {
    try {
      PhoneAuthCredential credential = PhoneAuthProvider.credential(
          verificationId: verificationId, smsCode: smsCode);

      await auth.signInWithCredential(credential);

      UserModel? user = await storeService.getInformationUserByPhoneNumber(
          phoneNumber: int.parse(phoneNumber));
      return user;
    } on FirebaseAuthException catch (e) {
      return Future.error(e.code);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<void> signUp(UserModel newUser) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: newUser.email, password: newUser.password);
      await storeService.addUser(newUser, result.user!);
    } on FirebaseAuthException catch (e) {
      return Future.error(e.code);
    } on FirebaseException catch (e) {
      return Future.error(e.code);
    }
  }

  Future<bool> resetPassword({email}) async {
    try {
      await auth.sendPasswordResetEmail(email: email);
      return true;
    } on FirebaseAuthException catch (e) {
      return Future.error(e.code);
    }
  }

  Future<void> signOutFirebase() async {
    try {
      await auth.signOut();
    } on FirebaseAuthException catch (e) {
      return Future.error(e.code);
    }
  }
}
