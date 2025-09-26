import 'package:flutter/material.dart';
import 'presentation/screens/splash_screen.dart';
import 'presentation/screens/login_screen.dart';
import 'presentation/screens/signup_screen.dart';
import 'presentation/screens/home_screen.dart';

class AppNavigation extends StatelessWidget {
  const AppNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => const SplashScreen(),
        "/login": (context) => LoginScreen(
          onLogin: () => Navigator.pushReplacementNamed(context, "/main"),
        ),
        "/signup": (context) => SignUpScreen(
          onSignup: () => Navigator.pushReplacementNamed(context, "/main"),
        ),
        "/homescreen": (context) => const HomeScreen(),
      },
    );
  }
}
