import 'package:easy_os_mobile/colors/custom_colors.dart';
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
        textTheme: TextTheme(bodyMedium: TextStyle(
          color: Colors.white,
          fontFamily: 'Mona_Sans',
          fontSize: 36
        )),
        scaffoldBackgroundColor: CustomColors.backgroundColor
      ),
      routes: {
        AppRoutes.home : (context) => Login()
      },
    );
  }
}
