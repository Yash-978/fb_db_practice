import 'package:flutter/material.dart';
import 'package:flutter_login/flutter_login.dart';
import 'package:get/get.dart';

import '../../Service/AuthService.dart';

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
                  AuthService()
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
                AuthService().continueWithGoogle().then((value) {
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
                  child: Text("Sign Up"),),
            ],
          )
        ]),
      ),
    );
  }
}*/
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
