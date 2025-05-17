import 'package:easy_os_mobile/utils/order_controller.dart';
import 'package:easy_os_mobile/widgets/order_form';
import 'package:flutter/material.dart';
import 'package:easy_os_mobile/widgets/loading_animation.dart';
import 'package:easy_os_mobile/widgets/custom_alert_dialog.dart';
import 'package:easy_os_mobile/domain/api/customer_api.dart';
import 'package:easy_os_mobile/domain/model/customer_model.dart';
import 'package:easy_os_mobile/routes/app_routes.dart';
import 'package:easy_os_mobile/utils/order_validator.dart';

class CreateOrder extends StatefulWidget {
  const CreateOrder({super.key});

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  final _api = CustomerApi();
  final _ctrl = OrderControllers();
  bool _saving = false;

  Future<void> _onSubmit() async {
    final errors = [
      OrderValidator.validateName(_ctrl.name.text),
      OrderValidator.validatePhone(_ctrl.phone.text, OrderControllers.phoneMask),
      OrderValidator.validateEmail(_ctrl.email.text),
      OrderValidator.validateDescription(_ctrl.description.text),
      OrderValidator.validateCost(_ctrl.cost.numberValue),
      OrderValidator.validateService(_ctrl.service.numberValue),
    ].where((e) => e != null).toList();

    if (errors.isNotEmpty) {
      await _showError(errors.first!);
      return;
    }

    setState(() => _saving = true);
    final model = CustomerModel(
      fullName: _ctrl.name.text.trim(),
      phone: _ctrl.phone.text.trim(),
      email: _ctrl.email.text.trim(),
      description: _ctrl.description.text.trim(),
      costPrice: _ctrl.cost.text.replaceAll(',', '.'),
      servicePrice: _ctrl.service.text.replaceAll(',', '.'),
    );
    await _api.postUser(model);
    if (mounted) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.ordersBody);
    }
  }

  Future<void> _showError(String msg) =>
      CustomAlertDialog.show(context, title: 'Erro', content: msg, confirmText: 'OK', cancelText: '');

  @override
  Widget build(BuildContext context) {
    return _saving
        ? const Center(child: LoadingAnimation(size: 120))
        : OrderForm(
            name: _ctrl.name,
            phone: _ctrl.phone,
            email: _ctrl.email,
            description: _ctrl.description,
            cost: _ctrl.cost,
            service: _ctrl.service,
            phoneMask: OrderControllers.phoneMask,
            onSubmit: _onSubmit,
          );
  }
}