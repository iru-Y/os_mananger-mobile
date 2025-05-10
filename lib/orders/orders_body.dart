import 'package:easy_os_mobile/colors/custom_colors.dart';
import 'package:easy_os_mobile/orders/show_orders.dart';
import 'package:easy_os_mobile/widgets/custom_modal_bottom_sheet.dart';
import 'package:easy_os_mobile/domain/secure_storage/secure_storage_service.dart';
import 'package:flutter/material.dart';
import 'package:easy_os_mobile/orders/create_order.dart';

class OrdersBody extends StatelessWidget {
  const OrdersBody({super.key});

  void _showCreateOrderModal(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: true,
      enableDrag: true,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.black54,
      builder: (BuildContext context) {
        return CustomModalBottomSheet(
          child: const CreateOrder(),
        );
      },
    );
  }

  Future<void> _logout(BuildContext context) async {
    await SecureStorageService().deleteAllTokens();
    Navigator.of(context).pushReplacementNamed('/');
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
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () => _logout(context),
          ),
        ],
      ),
      body: const ShowOrders(),
    );
  }
}
