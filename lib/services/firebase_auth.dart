import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

class AuthService {
  late FirebaseAuth auth;

  AuthService() {
    init();
  }

  init() async {
    await Firebase.initializeApp();
    auth = FirebaseAuth.instance;
  }

  Future<User?> loginByCredentials(String email, String password) async {
    User user;
    try {
      UserCredential result = await auth.signInWithEmailAndPassword(
          email: email, password: password);
      user = result.user!;
      print(user);
      return user;
    } catch (e) {
      print(e);
    }
  }

  Future<User?> signUp({email, password}) async {
    try {
      UserCredential result = await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: email, password: password);
      User user = result.user!;
      print(user);
      /*
      await FirebaseFirestore.instance
          .collection('users')
          .doc(user.uid)
          .set({});
          */
      return user;
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        print('The password provided is too weak.');
      } else if (e.code == 'email-already-in-use') {
        print('The account already exists for that email.');
      }
    }
  }

  Future<bool> resetPassword({email}) async {
    try {
      auth.sendPasswordResetEmail(email: email);
      return true;
    } catch (e) {
      return false;
    }
  }

  Future<bool> signOutFirebase() async {
    await auth.signOut();
    return true;
  }
}
