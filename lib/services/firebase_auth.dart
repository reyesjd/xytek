import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';


class AuthService {
  late FirebaseAuth auth;

  AuthService() {
    auth = FirebaseAuth.instance;
  }

  Future<User?> loginByCredentials(String email, String password) async {
    User user;
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = result.user!;
      return user;
    } on FirebaseAuthException catch (e) {
      return Future.error(e.code);
    }
  }

  Future<User?> signUp({email, password}) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user!;
      /*
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({});
          */
      return user;
    } on FirebaseAuthException catch (e) {
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

  Future<bool> signOutFirebase() async {
    try {
      await auth.signOut();
      return true;
    } catch (e) {
      return false;
    }
  }
}
