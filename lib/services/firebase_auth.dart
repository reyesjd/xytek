import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';

final FirebaseAuth auth = FirebaseAuth.instance;


Future<User> loginByCredentials(String email, String password) async {
  UserCredential result =
      await auth.signInWithEmailAndPassword(email: email, password: password);
  final User user = result.user!;

  print(user);
  await FirebaseAuth.instance.setPersistence(Persistence.LOCAL);
  return user;
}

Future<void> signUp(String email, String password) async {
  try {
    UserCredential result = await FirebaseAuth.instance
        .createUserWithEmailAndPassword(email: email, password: password);

    User user = result.user!;
    await FirebaseFirestore.instance.collection('users').doc(user.uid).set({});
  } on FirebaseAuthException catch (e) {
    if (e.code == 'weak-password') {
      print('The password provided is too weak.');
    } else if (e.code == 'email-already-in-use') {
      print('The account already exists for that email.');
    }
  }
}

Future<bool> signOutFirebase() async {
  await auth.signOut();
  return true;
}
