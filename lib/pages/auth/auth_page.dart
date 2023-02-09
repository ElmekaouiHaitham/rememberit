import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:remenberit/pages/home/home_page.dart';

import '../../constants/constants.dart';
import 'controller/auth_controller.dart';
import '../../constants/colors.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key}) : super(key: key);

  @override
  State<AuthPage> createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  Duration get loginTime => kDefaultDuration;

  final AuthController _authController = Get.find<AuthController>();

  Future<String?> _login(LoginData data) async {
    return await _authController.login(data.name, data.password);
  }

  Future<String?> _signupUser(SignupData data) async {
    return await _authController.signup(data.name!, data.password!);
  }

  Future<String?> _recoverPassword(String name) async {
    return await _authController.resetPassword(name);
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      scrollable: true,
      onLogin: _login,
      theme: LoginTheme(
        primaryColor: AppColors.mainColor,
        errorColor: Colors.red,
        titleStyle: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      onSignup: _signupUser,
      onSubmitAnimationCompleted: () {
        Get.to(const HomePage());
      },
      onRecoverPassword: _recoverPassword,
    );
  }
}
