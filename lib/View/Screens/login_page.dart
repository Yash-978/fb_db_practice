import 'package:flutter/material.dart';
import 'package:get/get.dart';

import '../../Service/AuthService.dart';

/*class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    final formKey= GlobalKey<FormState>();
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Page'),
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: w * 0.86,
            child: TextFormField(
              controller: emailController,
              decoration: InputDecoration(
                label: Text('Email'),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            height: h * 0.02,
          ),
          SizedBox(
            width: w * 0.86,
            child: TextFormField(
              controller: passwordController,
              obscureText: true,
              obscuringCharacter: '*',
              decoration: InputDecoration(
                label: Text('Password'),
                border: OutlineInputBorder(),
              ),
            ),
          ),
          SizedBox(
            height: h * 0.02,
          ),
          SizedBox(
            height: h * 0.06,
            width: w * 0.86,
            child: ElevatedButton(onPressed: () {}, child: Text('Login')),
          ),
          SizedBox(
            height: h * 0.02,
          ),
          SizedBox(
            height: h * 0.06,
            width: w * 0.86,
            child: OutlinedButton(
                onPressed: () {},
                child: Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset('assets/images/googleLogo.png'),
                    Text('Continue with Google'),
                  ],
                )),
          ),
          SizedBox(
            height: h * 0.02,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text("Don't have account ? "),
              OutlinedButton(
                onPressed: () {
                  Get.toNamed('signup');
                },
                child: Text(
                  'SignUp ',
                  style: TextStyle(color: Colors.orange.shade800),
                ),
              )
            ],
          ),
        ],
      ),
    );
  }
}*/
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
      appBar: AppBar(centerTitle: true,
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
                controller: _emailController,
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
                    ? "Password should have atleast 8 characters."
                    : null,
                controller: _passwordController,
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
                      AuthService()
                          .loginWithEmail(
                          _emailController.text, _passwordController.text)
                          .then((value) {
                        if (value == "Login Successful") {
                          Get.snackbar("Login", "Login Successful");
                          Get.offAndToNamed('/home');

                        } else {
                          Get.snackbar("Login", "$value", backgroundColor: Colors.red);

                        }
                      });
                    }
                  },
                  child: Text(
                    "Login",
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
                AuthService().continueWithGoogle().then((value) {
                  if (value == "Google Login Successful") {
                    ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(content: Text("Google Login Successful")));
                    Navigator.pushReplacementNamed(context, "/androidHome");
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                      content: Text(
                        value,
                        style: TextStyle(color: Colors.white),
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
                    Navigator.pushNamed(context, "/signUp");
                  },
                  child: Text("Sign Up"))
            ],
          )
        ]),
      ),
    );
  }
}