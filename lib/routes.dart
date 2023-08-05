import 'package:demo_app/screens/home_screen.dart';
import 'package:demo_app/screens/login_screen.dart';
import 'package:demo_app/screens/register_screen.dart';
import 'package:demo_app/screens/splash_screen.dart';
import 'package:flutter/material.dart';

class RouteGenerator {
  static const String splashPage = "/";
  static const String loginPage = "/login-page";
  static const String registerPage = "/register-page";
  static const String homePage = "/home-page";

  static Route generateRoute(RouteSettings settings) {
    switch (settings.name) {
      case splashPage:
        return MaterialPageRoute(
          builder: (context) => const SplashScreen(),
        );
      case loginPage:
        return MaterialPageRoute(
          builder: (context) => LoginScreen(),
        );
      case registerPage:
        return MaterialPageRoute(builder: (context) => const RegisterScreen());
      case homePage:
        return MaterialPageRoute(
          builder: (context) => HomeScreen(),
        );
      default:
        throw const FormatException("Route not found");
    }
  }
}
