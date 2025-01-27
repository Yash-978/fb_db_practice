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
                AuthService.authService.continueWithGoogle().then((value) {
                  if (value == "Google Login Successful") {
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Google Login Successfully'),
                        backgroundColor: Colors.green,
                      ),
                    );
                    // Navigator.of(context).pushNamed('/home');
                    ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
                        backgroundColor: Colors.green,
                        content: Text('Google Login Successful')));
                    Navigator.of(context).pushReplacementNamed('/home');
                    // Get.snackbar("Login", "Google Login SuccessFul");
                    // Get.offAllNamed('/home');
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                        backgroundColor: Colors.red,
                        content: Text('Google Login Failed ${value}')));
                    // Get.snackbar("Login", "Google Login Failed : $value",
                    //     backgroundColor: Colors.red);
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text('Google Login Successful'),
                        backgroundColor: Colors.red,
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
