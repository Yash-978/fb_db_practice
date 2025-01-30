import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_db_practice/image_uploader_app/view/screens/auth/check_user.dart';
import 'package:fb_db_practice/image_uploader_app/view/screens/auth/login_page.dart';
import 'package:fb_db_practice/image_uploader_app/view/screens/auth/sign_up.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:image_picker/image_picker.dart';

import 'package:provider/provider.dart';

import 'Service/AuthService.dart';
import 'firebase_options.dart';
import 'image_uploader_app/provider/provider.dart';
import 'image_uploader_app/service/firestore_service.dart';
import 'image_uploader_app/view/screens/home/home_page.dart';
import 'image_uploader_app/view/screens/image_upload_screen/image_upload.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'dart:io';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  // SystemChrome.setSystemUIOverlayStyle(
  //   SystemUiOverlayStyle(
  //     systemNavigationBarColor:
  //         SystemUiOverlayStyle.dark.systemNavigationBarColor,
  //   ),
  // );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    // return MultiProvider(
    //   providers: [
    //     ChangeNotifierProvider(
    //       create: (context) => ImageUploadProvider(),
    //     ),
    //   ],
    //   builder: (context, child) => MaterialApp(
    //     debugShowCheckedModeBanner: false,
    //     initialRoute: '/login',
    //     routes: {
    //       '/login': (context) => LoginPage(),
    //       // '/': (context) => CheckUser(),
    //       '/signup': (context) => SignUpPage(),
    //       '/home': (context) => UserHomePage(),
    //       '/upload': (context) => UploadImage(),
    //     },
    //   ),
    // );
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      getPages: [
        GetPage(
          name: '/',
          page: () => CheckUser(),
        ),
        GetPage(
          name: '/login',
          page: () => LoginPage(),
        ),
        GetPage(
          name: '/signUp',
          page: () => SignUpPage(),
        ),
        GetPage(
          name: '/user-home',
          page: () => UserHomePage(),
        ),
        GetPage(
          name: '/upload-image',
          page: () => UploadImage(),
        )
      ],
    );
  }
}

/*class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
// home: AuthPage(),
      getPages: [
        GetPage(
          name: '/',
          page: () => CheckUser(),
        ),
        GetPage(
          name: '/login',
          page: () => LoginScreen(), // Use flutter_login package
        ),
        GetPage(
          name: '/home',
          page: () => HomePage(),
        ),
      ],
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.orange.shade800),
        useMaterial3: true,
      ),
    );
  }
}*/
/*
flutter pub add get
google_sign_in
firebase_auth
cloud_firestore
image_picker
firebase_storage


change min sdk version to 23

/*
create new project  firebase
disable google analytics

run the second command in android studio console
flutterfire configure --project=fir-database-practice-f45ff

then and write project name in the console
com.example.projectName in this sequance

// if provider or getx
install this packages is flutter pub add firebase_core firebase_auth cloud_firestore firebase_messaging sqflite google_sign_in


//in build .gardle
compile sdk 34

in deafault config
multiDexEnabled true


in build.gradle(android/app/build.gradle)
min sdk = 23


in firebase in build use authentication
=> getstarted => signIn => enabled google sign and email and password enable it than save

for google sign in
create go to project settings
use this command any console
// keytool -list -v -alias androiddebugkey -keystore C:\Users\admin\.android\debug.keystore

use this command in .android this path //C:\Users\admin\.android
 keytool -list -v -keystore debug.keystore -alias androiddebugkey

*/*/
