import 'package:demo_app/routes.dart';
import 'package:demo_app/services/api_client_service.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'model/role.dart';

late SharedPreferences sp;
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  sp = await SharedPreferences.getInstance();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        FutureProvider<List<Role>?>.value(
            value: ApiClient.getUserRole(), initialData: null),
      ],
      child: MaterialApp(
        title: 'Demo App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            fontFamily: 'Plus Jakarta Sans',
            scaffoldBackgroundColor: Colors.white,
            appBarTheme:
                const AppBarTheme(backgroundColor: Colors.white, elevation: 0)),
        initialRoute: RouteGenerator.splashPage,
        onGenerateRoute: RouteGenerator.generateRoute,
      ),
    );
  }
}
