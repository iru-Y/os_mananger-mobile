import 'package:easy_os_mobile/orders/show_orders.dart';
import 'package:easy_os_mobile/routes/app_routes.dart';
import 'package:flutter/material.dart';

class OrdersBody extends StatelessWidget {
  const OrdersBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Ordens de Serviço'),
        centerTitle: true,
        leading: Builder(
          builder:
              (context) => Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back),
                    onPressed: () {
                      Navigator.of(context).popAndPushNamed(AppRoutes.login);
                    },
                  ),
                ],
              ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.post_add),
            onPressed: () {
              Navigator.of(context).popAndPushNamed(AppRoutes.createOrders);
            },
          ),
        ],
      ),
      body: ShowOrders(),
    );
  }
}
