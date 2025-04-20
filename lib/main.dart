import 'package:easy_os_mobile/login/login.dart';
import 'package:easy_os_mobile/routes/app_routes.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        fontFamily: 'Mona_Sans'
      ),
      routes: {
        AppRoutes.home : (context) => Login()
      },
    );
  }
}
