import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'Screen/Authpage.dart';
import 'Screen/Home.dart';
import 'Screen/Onboarding.dart';
import 'Screen/login_page.dart';
import 'Screen/register.dart';
import 'component/colo_extension.dart';
import 'firebase_options.dart';
import 'models/kick_models.dart';
import 'models/push_up_models.dart';
import 'provider/kickCounterProvider.dart';
import 'package:provider/provider.dart';

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
    return MultiProvider(
      providers: [
        BlocProvider(create: (context) => KickCounter()),
        ChangeNotifierProvider(create: (_) => KickCounterProvider()),
      ],
      child: MaterialApp(
        title: 'Moapp_final_project',
        theme: ThemeData(
          primaryColor: TColor.primaryColor1,
          colorScheme: ColorScheme.fromSeed(
            seedColor: TColor.primaryColor1,
          ),
          useMaterial3: true,
        ),
        initialRoute: '/onboarding',
        routes: {
          '/auth': (context) => const AuthPage(),
          '/login': (context) => const LoginPage(),
          '/onboarding': (context) => const OnBoardingView(),
          '/register': (context) => const RegisterPage(),
          '/': (context) => const MyHomePage(),
        },
      ),
    );
  }
}
