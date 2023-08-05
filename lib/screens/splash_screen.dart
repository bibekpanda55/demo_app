import 'package:demo_app/routes.dart';
import 'package:flutter/material.dart';

import '../main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);
  static const routeName = "/splash-screen";
  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 3)).then((value) async {
      if (sp.get("access_token") != null) {
        Navigator.of(context).pushNamed(RouteGenerator.homePage);
      } else {
        Navigator.of(context).pushNamed(RouteGenerator.loginPage);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.green[700]!,
        body: const Center(
            child: Text(
          "SPARC",
          style: TextStyle(
              color: Colors.white, fontSize: 70, fontWeight: FontWeight.bold),
        )));
  }
}
