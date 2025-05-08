import 'package:easy_os_mobile/colors/custom_colors.dart';
import 'package:easy_os_mobile/orders/show_orders.dart';
import 'package:flutter/material.dart';
import 'package:easy_os_mobile/orders/create_order.dart';

class OrdersBody extends StatelessWidget {
  const OrdersBody({super.key});

  void _showCreateOrderModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (BuildContext context) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).size.height * 0.1,
            left: 16.0,
            right: 16.0,
          ),
          child: Center(
            child: SingleChildScrollView(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [const CreateOrder()],
              ),
            ),
          ),
        );
      },
    );
  }

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
            Navigator.of(context).pop();
          },
        ),
        bottom: const PreferredSize(
          preferredSize: Size.fromHeight(0.5),
          child: Divider(height: 0.5, thickness: 0.5, color: Colors.white),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.post_add),
            onPressed: () => _showCreateOrderModal(context),
          ),
        ],
      ),
      body: const ShowOrders(),
    );
  }
}
