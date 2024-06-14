import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../fierstore/saveGoalAndProgress.dart';
import '../fierstore/getGoal.dart';
import '../fierstore/getProgress.dart';
import '../fierstore/upateGoal.dart';
import '../fierstore/updateProgress.dart';
import 'Home.dart';
import 'login_page.dart';
import '../provider/kickCounterProvider.dart';
import 'package:provider/provider.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({Key? key});

  @override
  _AuthPageState createState() => _AuthPageState();
}

class _AuthPageState extends State<AuthPage> {
  bool _isGoalProgressLoaded = false;

  @override
  Widget build(BuildContext context) {
    final kickCounterProvider = Provider.of<KickCounterProvider>(context);
    return Scaffold(
      body: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.active) {
            if (snapshot.hasData) {
              print('User is logged in: ${snapshot.data?.email}');

              // 이전에 호출한 적이 없다면 호출하고 플래그를 true로 설정합니다.
              if (!_isGoalProgressLoaded) {
                _fetchAndSetGoalAndProgress(context);
                _isGoalProgressLoaded = true;
              }

              print(
                  "goal: ${kickCounterProvider.goal}, progress: ${kickCounterProvider.count}");
              return MyHomePage();
            } else {
              print('User is not logged in');
              // 로그아웃 시에도 플래그를 리셋합니다.
              _isGoalProgressLoaded = false;
              return LoginPage();
            }
          }
          return Center(child: CircularProgressIndicator());
        },
      ),
    );
  }

  Future<void> _fetchAndSetGoalAndProgress(BuildContext context) async {
    try {
      // 비동기로 goal과 progress를 가져옵니다.
      final goal = await getGoal();
      final progress = await getProgress();

      // 가져온 값들을 KickCounterProvider에 저장합니다.
      if (goal != null && progress != null) {
        Provider.of<KickCounterProvider>(context, listen: false).setGoal(goal);
        Provider.of<KickCounterProvider>(context, listen: false)
            .setProgress1(progress);
      } else {
        print('Failed to fetch goal or progress from Firestore');
      }
    } catch (error) {
      print('Error fetching goal or progress: $error');
    }
  }
}
