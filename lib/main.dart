import 'package:fb_db_practice/Service/AuthService.dart';
import 'package:fb_db_practice/View/Screens/home_page.dart';
import 'package:fb_db_practice/View/Screens/signUp_page.dart';
import 'package:fb_db_practice/utils/global.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'Controller/controller.dart';
import 'Service/LocalDatabase.dart';
import 'Service/crud_services.dart';
import 'View/Component/dialogBox.dart';
import 'View/Screens/home.dart';
import 'View/Screens/login_page.dart';
import 'firebase_options.dart';

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
}

class CheckUser extends StatefulWidget {
  @override
  _CheckUserState createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {
  @override
  void initState() {
    super.initState();
    _checkLoginStatus();
  }

  void _checkLoginStatus() async {
    bool isLoggedIn = await AuthService.authService.isLoggedIn();
    if (isLoggedIn) {
      Get.offAllNamed('/home');
    } else {
      Get.offAllNamed('/login');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}

class LoginScreen extends StatelessWidget {
  Duration get loginTime => Duration(milliseconds: 2250);

  Future<String?> _authUser(LoginData data) async {
    String result =
        await AuthService.authService.loginWithEmail(data.name, data.password);
    return result == "Login Successful" ? null : result;
  }

  Future<String?> _signupUser(SignupData data) async {
    String result = await AuthService.authService
        .createAccountWithEmail(data.name!, data.password!);
    return result == "Account Created" ? null : result;
  }

  Future<String?> _recoverPassword(String email) async {
    // Mock password recovery
    return email == "test@example.com"
        ? null
        : "User not found. Please try again.";
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'MyApp',
      onLogin: _authUser,
      onSignup: _signupUser,
      onRecoverPassword: _recoverPassword,
      onSubmitAnimationCompleted: () async {
        await Future.delayed(Duration(milliseconds: 500));
        Get.offAllNamed('/home');
      },
      theme: LoginTheme(
        primaryColor: Colors.blue,
        accentColor: Colors.white,
        buttonTheme: LoginButtonTheme(
          splashColor: Colors.green,
          backgroundColor: Colors.blueAccent,
          highlightColor: Colors.lightBlue,
        ),
      ),
      messages: LoginMessages(
        userHint: 'Email',
        passwordHint: 'Password',
        confirmPasswordHint: 'Confirm Password',
        loginButton: 'LOGIN',
        signupButton: 'SIGN UP',
        recoverPasswordButton: 'Forgot Password?',
        recoverPasswordDescription:
            'We will send you instructions to reset your password.',
        goBackButton: 'GO BACK',
      ),
    );
  }
}


// class CheckUser extends StatefulWidget {
//   const CheckUser({super.key});
//
//   @override
//   State<CheckUser> createState() => _CheckUserState();
// }
//
// class _CheckUserState extends State<CheckUser> {
//   @override
//   void initState() {
//     super.initState();
//     AuthService.authService.isLoggedIn().then((value) {
//       if (value) {
//         Get.offAllNamed('/home');
//       } else {
//         Get.offAllNamed('/login');
//       }
//     });
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body: Center(
//         child: CircularProgressIndicator(),
//       ),
//     );
//   }
// }

/*class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  Future<String?> _authUser(LoginData data) async {
    return await AuthService.authService
        .loginWithEmail(data.name, data.password);
  }

  Future<String?> _signupUser(SignupData data) async {
    if (data.name == null || data.password == null) {
      return 'Invalid email or password.';
    }
    return await AuthService.authService
        .createAccountWithEmail(data.name!, data.password!);
  }

  Future<String?> _recoverPassword(String email) async {
    // Implement password recovery logic here if needed
    return 'Password recovery is not implemented yet.';
  }

  @override
  Widget build(BuildContext context) {
    return FlutterLogin(
      title: 'My App',
      onLogin: _authUser,
      onSignup: _signupUser,
      onRecoverPassword: _recoverPassword,
      onSubmitAnimationCompleted: () {
        Get.offAllNamed('/home'); // Navigate to the home page upon success
      },
      theme: LoginTheme(
        primaryColor: Colors.orange.shade600,
        accentColor: Colors.white,
        errorColor: Colors.red,
      ),
    );
  }
}*/

// class HomePage extends StatelessWidget {
//   const HomePage({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: Text('Home Page'),
//         actions: [
//           IconButton(
//             icon: Icon(Icons.logout),
//             onPressed: () async {
//               await AuthService.authService.logout();
//               Get.offAllNamed('/login'); // Redirect to login after logout
//             },
//           ),
//         ],
//       ),
//       body: Center(
//         child: Text('Welcome to the Home Page!'),
//       ),
//     );
//   }
// }

// Example Dashboard Screen

/*class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Login'),
      ),
      body: Form(
        key: formKey,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
              width: w * .9,
              child: TextFormField(
                validator: (value) =>
                value!.isEmpty ? "Email cannot be empty." : null,
                controller: emailController,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Email"),
                ),
              )),
          SizedBox(
            height: 10,
          ),
          SizedBox(
              width: w * 0.9,
              child: TextFormField(
                validator: (value) => value!.length < 8
                    ? "Password should have at least 8 characters."
                    : null,
                controller: passwordController,
                obscureText: true,
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Password"),
                ),
              )),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            height: 65,
            width: w * .9,
            child: ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  AuthService.authService
                      .loginWithEmail(
                      emailController.text, passwordController.text)
                      .then(
                        (value) {
                      if (value == "Login Successful") {
                        Get.snackbar("Login", "Login Successful");
                        Get.offAllNamed('/home');
                      } else {
                        Get.snackbar("Login", "$value",
                            backgroundColor: Colors.red);
                      }
                    },
                  );
                }
              },
              child: Text(
                "Login",
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          SizedBox(
            width: w * 0.9,
            height: h * 0.06,
            child: OutlinedButton(
              onPressed: () {
                AuthService.authService.continueWithGoogle().then((value) {
                  if (value == "Google Login Successful") {
                    Get.snackbar("Login", "Google Login SuccessFul");
                    Get.offAllNamed('/home');
                  } else {
                    Get.snackbar("Login", "Google Login Failed : $value",
                        backgroundColor: Colors.red);
                  }
                });
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/googleLogo.png",
                    height: 30,
                    width: 30,
                  ),
                  Text("Continue with Google"),
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have and account?"),
              TextButton(
                  onPressed: () {
                    Get.toNamed('/signup');
                  },
                  child: Text("Sign Up"))
            ],
          )
        ]),
      ),
    );
  }
}




class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Sign Up '),
      ),
      body: Form(
        key: formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
                width: w * .9,
                child: TextFormField(
                  validator: (value) =>
                  value!.isEmpty ? "Email cannot be empty." : null,
                  controller: emailController,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Email"),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                width: w * 0.9,
                child: TextFormField(
                  validator: (value) => value!.length < 8
                      ? "Password should have at least 8 characters."
                      : null,
                  controller: passwordController,
                  obscureText: true,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    label: Text("Password"),
                  ),
                )),
            SizedBox(
              height: 10,
            ),
            SizedBox(
                height: 65,
                width: w * .9,
                child: ElevatedButton(
                    onPressed: () {
                      if (formKey.currentState!.validate()) {
                        AuthService.authService
                            .createAccountWithEmail(
                            emailController.text, passwordController.text)
                            .then((value) {
                          if (value == "Account Created") {
                            Get.snackbar(
                                "Account info", "Account created successfully");
                            Get.offAllNamed('/home');
                          } else {
                            Get.snackbar("Account info", "$value",
                                backgroundColor: Colors.red);
                          }
                        });
                      }
                    },
                    child: Text(
                      "Sign Up",
                      style: TextStyle(fontSize: 16),
                    ))),
            SizedBox(
              height: 10,
            ),
            SizedBox(
              width: w * 0.9,
              height: h * 0.06,
              child: OutlinedButton(
                onPressed: () {
                  // AuthService().continueWithGoogle().then((value) {
                  //   if (value == "Google Login Successful") {
                  //     Get.snackbar("Account info", "Google Login Successful");
                  //   } else {
                  //     Get.snackbar("Account info", "$value",
                  //         backgroundColor: Colors.red);
                  //   }
                  // });
                  AuthService.authService.continueWithGoogle().then((value) {
                    if (value == "Google Login Successful") {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text("Google Login Successful")));
                      Navigator.pushReplacementNamed(context, "/home");
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(
                            value,
                            style: TextStyle(color: Colors.white),
                          ),
                          backgroundColor: Colors.red.shade400,
                        ),
                      );
                    }
                  });
                },
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/images/googleLogo.png",
                      height: 30,
                      width: 30,
                    ),
                    Text("Continue with Google"),
                  ],
                ),
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Already have Account!",
                ),
                TextButton(
                  onPressed: () {
                    Get.toNamed('/login');
                  },
                  child: Text(
                    "Login",
                  ),
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}


class CheckUser extends StatefulWidget {
  const CheckUser({super.key});

  @override
  State<CheckUser> createState() => _CheckUserState();
}

class _CheckUserState extends State<CheckUser> {

  @override
  void initState() {
    super.initState();
    AuthService.authService.isLoggedIn().then(
      (value) {
        if (value) {
          Get.offAllNamed('/home');
        } else {
          Get.offAllNamed('/login');
        }
      },
    );
  }

  Widget build(BuildContext context) {
    return Center(child: CircularProgressIndicator());
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
