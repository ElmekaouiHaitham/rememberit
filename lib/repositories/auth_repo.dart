import 'package:get/get.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthRepo extends GetxService {
  FirebaseAuth firebaseAuth = FirebaseAuth.instance;

  // get current user

  User? get currentUser => firebaseAuth.currentUser;

  bool isLoggedIn() {
    return firebaseAuth.currentUser != null;
  }

  Future<void> signOut() {
    return firebaseAuth.signOut();
  }

  // login

  Future<void> login(String email, String password) async {
    await firebaseAuth.signInWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> signup(String email, String password) async {
    await firebaseAuth.createUserWithEmailAndPassword(
        email: email, password: password);
  }

  Future<void> resetPassword(String email) async {
    await firebaseAuth.sendPasswordResetEmail(email: email);
  }
}
