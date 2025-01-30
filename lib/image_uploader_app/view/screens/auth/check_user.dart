
import 'package:fb_db_practice/image_uploader_app/view/screens/auth/login_page.dart';
import 'package:fb_db_practice/image_uploader_app/view/screens/home/home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Service/AuthService.dart';
// class CheckUser extends StatefulWidget {
//   @override
//   _CheckUserState createState() => _CheckUserState();
// }
//
// class _CheckUserState extends State<CheckUser> {
//   @override
//   void initState() {
//     super.initState();
//     _checkLoginStatus();
//   }
//
//   void _checkLoginStatus() async {
//     bool isLoggedIn = await AuthService.authService.isLoggedIn();
//     if (isLoggedIn) {
//       Get.offAllNamed('/home');
//     } else {
//       Get.offAllNamed('/login');
//     }
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(child: CircularProgressIndicator()),
//     );
//   }
// }

class CheckUser extends StatelessWidget {
  const CheckUser({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      return LoginPage();
    } else {
      return UserHomePage();
    }
  }
}