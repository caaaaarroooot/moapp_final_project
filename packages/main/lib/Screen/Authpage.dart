import "package:firebase_auth/firebase_auth.dart";
import "package:flutter/material.dart";

import 'Home.dart';
import 'login_page.dart';

class AuthPage extends StatelessWidget {
  const AuthPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              // 로그인된 상태를 콘솔에 출력
              print('User is logged in: ${snapshot.data?.email}');
              // 로그인된 상태에서는 홈 페이지로 이동
              return MyHomePage(); // Home.dart에서 HomePage 위젯으로 변경하세요.
            } else {
              // 로그인되지 않은 상태를 콘솔에 출력
              print('User is not logged in');
              // 로그인되지 않은 상태에서는 로그인 페이지로 이동
              return LoginPage();
            }
          }
          // 데이터가 아직 로드되지 않은 경우 로딩 스피너를 표시
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }
}
