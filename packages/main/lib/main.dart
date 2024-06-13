import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import 'Screen/Authpage.dart';
import 'Screen/Home.dart';
import 'Screen/Onboarding.dart';
import 'Screen/login_page.dart';
import 'Screen/register.dart';
import 'component/colo_extension.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        primaryColor: TColor.primaryColor1,
        colorScheme: ColorScheme.fromSeed(
          seedColor: TColor.primaryColor1,
        ),
        useMaterial3: true,
      ),
      // home: const MyHomePage(title: 'Flutter Demo Home Page'),
      initialRoute: '/onboarding',
      routes: {
        '/auth': (context) => const AuthPage(),
        '/login': (context) => const LoginPage(),
        '/onboarding': (context) => const OnBoardingView(),
        '/register': (context) => const RegisterPage(),
        '/': (context) => const MyHomePage(),
      },
    );
  }
}
