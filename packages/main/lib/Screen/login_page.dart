
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../component/SignUpBtn.dart';
import '../component/login_textfield.dart';
import '../component/my_button.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageYoutubeState();
}

class _LoginPageYoutubeState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  void signUserIn() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );
    try {
      print(usernameController.text);
      print(passwordController.text);
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: usernameController.text,
        password: passwordController.text,
      );
      // 로그인 성공 시 추가 작업 (예: 화면 전환)
      print('로그인 성공');
      Navigator.pop(context);
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context);
      print('Code: ${e.code}');
      print('Message: ${e.message}');
      if (e.code == 'invalid-email') {
        print('wrong email');
        wrongEmailMessage();
      } else if (e.code == 'invalid-credential') {
        print('wrong pw');
        wrongPasswordMessage();
      } else {
        print("??");
      }
    }
  }

  void wrongEmailMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Incorrect Email'),
        );
      },
    );
  }

  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Incorrect Email'),
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color.fromARGB(255, 240, 240, 240),
      body: SingleChildScrollView(
        child: SafeArea(
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  height: 50,
                ),
                const Icon(
                  Icons.lock,
                  size: 100,
                ),
                const SizedBox(
                  height: 50,
                ),
                const Text(
                  "Welcome back you\'ve been missed!",
                  style: TextStyle(
                    color: Colors.black54,
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFieldWidget(
                  controller: usernameController,
                  hintText: 'UserId',
                  obscureText: false,
                ),
                const SizedBox(
                  height: 25,
                ),
                TextFieldWidget(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                const Padding(
                  padding: EdgeInsets.fromLTRB(0, 0, 25, 0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Text(
                        "Forgot Password?",
                        style: TextStyle(color: Colors.black54),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                MyButton(
                  text: "Log In",
                  onTap: signUserIn,
                ),
                const SizedBox(
                  height: 50,
                ),
                const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 25),
                  child: Row(
                    children: [
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 10),
                        child: Text("Or continue with"),
                      ),
                      Expanded(
                        child: Divider(
                          thickness: 0.5,
                        ),
                      ),
                    ],
                  ),
                ),
                const GoogleSignInButton(),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Not a mamber?",
                        style: TextStyle(
                          color: Colors.black54,
                        )),
                    const SizedBox(
                      width: 8,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/register');
                      },
                      child: const Text(
                        "Register now",
                        style: TextStyle(
                          color: Colors.blue,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
