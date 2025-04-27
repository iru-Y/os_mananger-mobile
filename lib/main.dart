import 'package:easy_os_mobile/colors/custom_colors.dart';
import 'package:easy_os_mobile/login/login.dart';
import 'package:easy_os_mobile/orders/create_order.dart';
import 'package:easy_os_mobile/orders/view_orders.dart';
import 'package:easy_os_mobile/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        textTheme: TextTheme(
          bodyMedium: TextStyle(
            color: Colors.white,
            fontFamily: 'Work_Sans',
            fontSize: 36,
          ),
          bodySmall: TextStyle(fontFamily: 'Mona_Sans', fontSize: 24),
        ),
        scaffoldBackgroundColor: CustomColors.backgroundColor,
      ),
      routes: {
        AppRoutes.viewOrders: (context) => ViewOrders(),
        AppRoutes.createOrders: (context) => CreateOrder(),
        AppRoutes.login: (context) => Login(),
      },
    );
  }
}
