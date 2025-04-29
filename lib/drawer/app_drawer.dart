import 'package:easy_os_mobile/routes/app_routes.dart';
import 'package:flutter/material.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(child: Text('Menu')),
          ListTile(
            title: Text('Criar Nova Ordem de Serviço'),
            onTap:
                () => Navigator.of(
                  context,
                ).pushReplacementNamed(AppRoutes.createOrders),
          ),
          ListTile(
            title: Text('Ver Todas as Ordens de Serviço'),
            onTap:
                () => Navigator.of(
                  context,
                ).pushReplacementNamed(AppRoutes.viewOrders),
          ),
        ],
      ),
    );
  }
}
