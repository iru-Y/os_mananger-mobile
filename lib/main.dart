import 'package:easy_os_mobile/colors/custom_colors.dart';
import 'package:easy_os_mobile/login/login.dart';
import 'package:easy_os_mobile/orders/create_order.dart';
import 'package:easy_os_mobile/orders/orders_body.dart';
import 'package:easy_os_mobile/orders/show_orders.dart';
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
      debugShowCheckedModeBanner: false,

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
        AppRoutes.showOrders: (context) => ShowOrders(),
        AppRoutes.createOrders: (context) => CreateOrder(),
        AppRoutes.login: (context) => Login(),
        AppRoutes.ordersBody: (context) => OrdersBody(),
      },
    );
  }
}
