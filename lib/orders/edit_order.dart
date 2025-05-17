import 'package:easy_os_mobile/utils/order_controller.dart';
import 'package:easy_os_mobile/widgets/order_form.dart';
import 'package:flutter/material.dart';
import 'package:easy_os_mobile/widgets/loading_animation.dart';
import 'package:easy_os_mobile/widgets/custom_alert_dialog.dart';
import 'package:easy_os_mobile/domain/api/customer_api.dart';
import 'package:easy_os_mobile/domain/model/customer_model.dart';
import 'package:easy_os_mobile/utils/order_validator.dart';

class EditOrder extends StatefulWidget {
  final CustomerModel customer;
  const EditOrder({super.key, required this.customer});

  @override
  State<EditOrder> createState() => _EditOrderState();
}

class _EditOrderState extends State<EditOrder> {
  final _api = CustomerApi();
  late final OrderControllers _ctrl;
  bool _saving = false;

  @override
  void initState() {
    super.initState();
    _ctrl = OrderControllers(model: widget.customer);
  }

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
    final success = await _api.patchCustomer(widget.customer.id!, model) != null;
    if (!success) {
      await _showError('Erro ao salvar alterações');
      setState(() => _saving = false);
    } else if (mounted) {
      Navigator.of(context).pop(true);
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