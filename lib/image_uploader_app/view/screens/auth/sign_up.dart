import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../../../Service/AuthService.dart';

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
                            ScaffoldMessenger.of(context).showSnackBar(
                                const SnackBar(
                                    backgroundColor: Colors.red,
                                    content: Text('Account Successful')));
                            Navigator.pushNamed(context, '/uploadImage');
                            // Get.snackbar(
                            //     "Account info", "Account created successfully");
                            // Get.offAllNamed('/home');
                          } else {
                            // Get.snackbar("Account info", "$value",
                            //     backgroundColor: Colors.red);
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
                  AuthService.authService.continueWithGoogle().then((value) {
                    if (value == "Google Login Successful") {
                      Get.snackbar("Account info", "Google Login Successful");
                    } else {
                      Get.snackbar("Account info", "$value",
                          backgroundColor: Colors.red);
                    }
                  });
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
                    // Get.toNamed('/login');
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
