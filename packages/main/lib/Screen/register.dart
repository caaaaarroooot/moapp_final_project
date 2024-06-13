import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../component/SignUpBtn.dart';
import '../component/login_textfield.dart';
import '../component/my_button.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  void signUserUp() async {
    showDialog(
      context: context,
      builder: (context) {
        return const Center(
          child: CircularProgressIndicator(),
        );
      },
    );

    try {
      if (passwordController.text == confirmPasswordController.text) {
        await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: usernameController.text,
          password: passwordController.text,
        );

        // 회원가입 성공 후 로그인 페이지로 이동
        Navigator.pop(context); // ProgressDialog 닫기
        Navigator.pushNamed(context, '/auth');
      } else {
        Navigator.pop(context); // ProgressDialog 닫기
        notMatchedPassword();
      }
    } on FirebaseAuthException catch (e) {
      Navigator.pop(context); // ProgressDialog 닫기
      print('Code: ${e.code}');
      print('Message: ${e.message}');
      if (e.code == 'email-already-in-use') {
        print('wrong email');
        wrongEmailMessage();
      } else if (e.code == 'weak-password') {
        print('weak-password');
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
          title: Text('Account is Already exist'),
        );
      },
    );
  }

  void wrongPasswordMessage() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Password is too weak'),
        );
      },
    );
  }

  void notMatchedPassword() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Passwords don\'t matched!'),
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
                  "Let's create account for you",
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
                  height: 10,
                ),
                TextFieldWidget(
                  controller: passwordController,
                  hintText: 'Password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextFieldWidget(
                  controller: confirmPasswordController,
                  hintText: 'Confirm Password',
                  obscureText: true,
                ),
                const SizedBox(
                  height: 25,
                ),
                MyButton(
                  text: "Sign Up",
                  onTap: signUserUp,
                ),
                const SizedBox(
                  height: 25,
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
                // const SizedBox(
                //   height: 10,
                // ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Already have an account?",
                        style: TextStyle(
                          color: Colors.black54,
                        )),
                    const SizedBox(
                      width: 8,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/auth');
                      },
                      child: const Text(
                        "Login now",
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
