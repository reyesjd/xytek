import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:xytek/data/models/user_model.dart';

class AuthService {
  late FirebaseAuth auth;
  late FirebaseFirestore store;

  AuthService() {
    auth = FirebaseAuth.instance;
    store = FirebaseFirestore.instance;
  }

  Future<UserModel?> getLoggedUser() async {
    if (auth.currentUser != null) {
      try {
        if (auth.currentUser!.phoneNumber != null) {
          if (auth.currentUser!.phoneNumber!.isNotEmpty) {
            String colPhoneNumber = auth.currentUser!.phoneNumber!.substring(3);
            UserModel? user = await getInformationUserByPhoneNumber(
                phoneNumber: int.parse(colPhoneNumber));
            return user;
          }
        }
        UserModel? user =
            await getInformationUserByUserID(userId: auth.currentUser!.uid);
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
      return getInformationUserByUserID(userId: user.uid);
    } on FirebaseAuthException catch (e) {
      return Future.error(e.code);
    }
  }

  Future<void> logingByPhoneNumber({phoneNumber, credentials}) async {
    try {
      UserModel? user = await getInformationUserByPhoneNumber(
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

      UserModel? user = await getInformationUserByPhoneNumber(
          phoneNumber: int.parse(phoneNumber));
      return user;
    } on FirebaseAuthException catch (e) {
      return Future.error(e.code);
    } catch (e) {
      return Future.error(e);
    }
  }

  Future<UserModel?> getInformationUserByUserID({userId}) async {
    try {
      var infoUser = await FirebaseFirestore.instance
          .collection('users')
          .doc(userId)
          .get();
      var dicc = infoUser.data();
      if (dicc!.isNotEmpty) {
        UserModel? user = UserModel.fromMap(dicc);
        return user;
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<UserModel?> getInformationUserByPhoneNumber({phoneNumber}) async {
    try {
      var infoUser = store
          .collection('users')
          .where("phoneNumber", isEqualTo: phoneNumber);
      var result = await infoUser.get();
      var dicc = result.docs.first.data();
      if (dicc.isNotEmpty) {
        return UserModel.fromMap(result.docs.first.data());
      } else {
        return null;
      }
    } catch (e) {
      return null;
    }
  }

  Future<void> signUp(UserModel newUser) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(
              email: newUser.email, password: newUser.password);

      User user = result.user!;
      var dicc = newUser.toMap();
      var uid = user.uid;

      dicc.addAll({"uid": uid});

      await store.collection('users').doc(uid).set(dicc);
      await store.waitForPendingWrites();
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
