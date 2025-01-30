/*
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Service/AuthService.dart';

class LoginPage extends StatefulWidget {
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
        title: const Text('Login'),
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
                decoration: const InputDecoration(
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
                decoration: const InputDecoration(
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
                      .loginWithEmail(emailController.text.trim(),
                          passwordController.text.trim())
                      .then(
                    (value) {
                      if (value == "Login Successful") {
                        // Get.snackbar("Login", "Login Successful");
                        ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                                backgroundColor: Colors.red,
                                content: Text('Login Successful')));
                        Navigator.pushNamed(context, '/home');
                      } else {
                        // Get.snackbar("Login", "$value",
                        //     backgroundColor: Colors.red);
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            backgroundColor: Colors.red,
                            content: Text('Login ${value}')));
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
                // AuthService.authService.continueWithGoogle().then((value) {
                //   if (value == "Google Login Successful") {
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(
                //         content: Text('Google Login Successfully'),
                //         backgroundColor: Colors.green,
                //       ),
                //     );
                //     // Navigator.of(context).pushNamed('/home');
                //     ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                //         backgroundColor: Colors.green,
                //         content: Text('Google Login Successful')));
                //     Navigator.of(context).pushReplacementNamed('/home');
                //     // Get.snackbar("Login", "Google Login SuccessFul");
                //     // Get.offAllNamed('/home');
                //   } else {
                //     ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //         backgroundColor: Colors.red,
                //         content: Text('Google Login Failed ${value}')));
                //     // Get.snackbar("Login", "Google Login Failed : $value",
                //     //     backgroundColor: Colors.red);
                //     ScaffoldMessenger.of(context).showSnackBar(
                //       const SnackBar(
                //         content: Text('Google Login Successful'),
                //         backgroundColor: Colors.red,
                //       ),
                //     );
                //   }
                // });
                AuthService.authService.continueWithGoogle().then(
                  (value) {
                    if (value == "Google Login Successful") {
                      ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Google Login Successfull')));
                      Navigator.pushReplacementNamed(context, '/home');
                    }
                    else
                      {
                        ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(content: Text('$value')));
                        Navigator.pushReplacementNamed(context, '/home');
                      }
                  },
                );
              },
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Image.asset(
                    "assets/images/googleLogo.png",
                    height: 30,
                    width: 30,
                  ),
                  const Text("Continue with Google"),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have and account?"),
              TextButton(
                onPressed: () {
                  // Get.toNamed('/signup');
                  Navigator.pushNamed(context, '/signup');
                },
                child: Text("Sign Up"),
              ),
            ],
          )
        ]),
      ),
    );
  }
}
*/
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fb_db_practice/Controller/controller.dart';
import 'package:fb_db_practice/Service/AuthService.dart';
import 'package:fb_db_practice/image_uploader_app/service/firestore_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final formKey = GlobalKey<FormState>();
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Login'),
      ),
      body: Form(
        key: formKey,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
          SizedBox(
              width: w * .9,
              child: TextFormField(
                validator: (value) =>
                    value!.isEmpty ? "Email cannot be empty." : null,
                controller: _emailController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Email"),
                ),
              )),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              width: w * 0.9,
              child: TextFormField(
                validator: (value) => value!.length < 8
                    ? "Password should have atleast 8 characters."
                    : null,
                controller: _passwordController,
                obscureText: true,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  label: Text("Password"),
                ),
              )),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
              height: 65,
              width: w * .9,
              child: ElevatedButton(
                  onPressed: () {
                    if (formKey.currentState!.validate()) {
                      AuthService.authService
                          .loginWithEmail(_emailController.text.trim(),
                              _passwordController.text.trim())
                          .then((value) {
                        if (value == "Login Successful") {
                          ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text("Login Successful")));
                          Navigator.pushReplacementNamed(context, "/user-home");
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                              value,
                              style: const TextStyle(color: Colors.white),
                            ),
                            backgroundColor: Colors.red.shade400,
                          ));
                        }
                      });
                    }
                  },
                  child: const Text(
                    "Login",
                    style: TextStyle(fontSize: 16),
                  ))),
          const SizedBox(
            height: 10,
          ),
          SizedBox(
            width: w * 0.9,
            height: h * 0.06,
            child: OutlinedButton(
              onPressed: () {
                AuthService.authService.continueWithGoogle().then((value) {
                  if (value == "Google Login Successful") {
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        content: Text("Google Login Successful")));
                    UserModel user = UserModel(
                        email:
                            FirebaseAuth.instance.currentUser!.email.toString(),
                        name: FirebaseAuth.instance.currentUser!.displayName
                            .toString(),
                        profile: FirebaseAuth.instance.currentUser!.photoURL
                            .toString(),
                        gallery: List.empty());

                    // FirestoreService.instance.addUser(
                    //   name: user.name,
                    //   profileUrl: user.profile,
                    // );
                    Navigator.pushReplacementNamed(context, "/user-home");
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        value,
                        style: const TextStyle(color: Colors.white),
                      ),
                      backgroundColor: Colors.red.shade400,
                    ));
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
                  const Text("Continue with Google"),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Don't have and account?"),
              TextButton(
                  onPressed: () {
                    Navigator.pushNamed(context, "/signUp");
                  },
                  child: const Text("Sign Up"))
            ],
          )
        ]),
      ),
    );
  }
}
