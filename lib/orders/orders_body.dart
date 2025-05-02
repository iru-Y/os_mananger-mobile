import 'package:easy_os_mobile/colors/custom_colors.dart';
import 'package:easy_os_mobile/orders/show_orders.dart';
import 'package:easy_os_mobile/routes/app_routes.dart';
import 'package:flutter/material.dart';

class OrdersBody extends StatelessWidget {
  const OrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Ordens de Serviço'),
        centerTitle: true,
        backgroundColor: CustomColors.backgroundColor,
        iconTheme: const IconThemeData(color: Colors.white),
        actionsIconTheme: const IconThemeData(color: Colors.white),
        titleTextStyle: const TextStyle(
          color: Colors.white,
          fontSize: 20,
          fontWeight: FontWeight.w600,
        ),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.of(context).popAndPushNamed(AppRoutes.login);
          },
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.post_add),
            onPressed: () {
              Navigator.of(context).popAndPushNamed(AppRoutes.createOrders);
            },
          ),
        ],
      ),
      body: const ShowOrders(),
    );
  }
}
