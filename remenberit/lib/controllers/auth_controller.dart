import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:remenberit/view/auth_page.dart';
import '../constants/constants.dart';
import '../repositories/auth_repo.dart';

class AuthController extends GetxController {
  final AuthRepo _authRepo;

  AuthController(this._authRepo);
  User? _user;
  User? get user => _user;
  // LOGOUT
  Future<void> signOut() async {
    try {
      _user = null;
      await _authRepo.signOut();
      // go to auth page
      Get.to(const AuthPage());
      Get.snackbar('Success', 'You have successfully signed out',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: kDefaultDuration);
    } catch (e) {
      Get.snackbar(
        'Error',
        e.toString(),
        snackPosition: SnackPosition.BOTTOM,
        backgroundColor: Colors.red,
        colorText: Colors.white,
        duration: const Duration(seconds: 7),
      );
    }
  }

  Future<String?> login(String email, String password) async {
    try {
      await _authRepo.login(email, password);
      // get the user
      _user = _authRepo.currentUser;
      Get.snackbar('Login Successful', 'Welcome ${_user!.email}',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          duration: kDefaultDuration);
    } catch (e) {
      return e.toString();
    }
    return null;
  }

  // is logged in
  bool isLoggedIn() {
    if (_authRepo.isLoggedIn()) {
      _user = _authRepo.currentUser;
      return true;
    }
    return false;
  }

  Future<String?> signup(String email, String password) async {
    try {
      await _authRepo.signup(email, password);
      _user = _authRepo.currentUser;
      Get.snackbar('Success', 'You have successfully signed up',
          backgroundColor: Colors.green,
          colorText: Colors.white,
          snackPosition: SnackPosition.BOTTOM,
          duration: kDefaultDuration);
    } catch (e) {
      // snack bar to show error
      return e.toString();
    }
    return null;
  }

  // password reset
  Future<String?> resetPassword(String email) async {
    try {
      await _authRepo.resetPassword(email);
      Get.snackbar(
          'Password Reset', 'Check your email for a password reset link',
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor: Colors.green,
          duration: kDefaultDuration);
    } catch (e) {
      e.toString();
    }
    return null;
  }
}
