import 'package:easy_os_mobile/utils/order_controller.dart';
import 'package:easy_os_mobile/widgets/order_form.dart';
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
  final CustomerApi _customerApi = CustomerApi();
  final OrderControllers _orderControllers = OrderControllers();
  bool _saving = false;

  Future<void> _onSubmit() async {
    final errors = [
      OrderValidator.validateName(_orderControllers.name.text),
      OrderValidator.validatePhone(_orderControllers.phone.text, OrderControllers.phoneMask),
      OrderValidator.validateEmail(_orderControllers.email.text),
      OrderValidator.validateDescription(_orderControllers.description.text),
      OrderValidator.validateCost(_orderControllers.cost.numberValue),
      OrderValidator.validateService(_orderControllers.service.numberValue),
    ].where((e) => e != null).toList();

    if (errors.isNotEmpty) {
      await _showError(errors.first!);
      return;
    }

    setState(() => _saving = true);
    final model = CustomerModel(
      fullName: _orderControllers.name.text.trim(),
      phone: _orderControllers.phone.text.trim(),
      email: _orderControllers.email.text.trim(),
      description: _orderControllers.description.text.trim(),
      costPrice: _orderControllers.cost.text.replaceAll(',', '.'),
      servicePrice: _orderControllers.service.text.replaceAll(',', '.'),
    );
    await _customerApi.postUser(model);
    if (mounted) {
      Navigator.of(context).pushReplacementNamed(AppRoutes.ordersBody);
    }
  }

  Future<void> _showError(String msg) =>
      CustomAlertDialog.show(context, title: 'Erro', content: msg, confirmText: 'OK', cancelText: '', isError: true);

  @override
  Widget build(BuildContext context) {
    return _saving
        ? const Center(child: LoadingAnimation(size: 120))
        : OrderForm(
            name: _orderControllers.name,
            phone: _orderControllers.phone,
            email: _orderControllers.email,
            description: _orderControllers.description,
            cost: _orderControllers.cost,
            service: _orderControllers.service,
            phoneMask: OrderControllers.phoneMask,
            onSubmit: _onSubmit,
          );
  }
}