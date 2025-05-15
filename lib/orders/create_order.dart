import 'dart:async';

import 'package:easy_os_mobile/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

import 'package:easy_os_mobile/domain/model/customer_model.dart';
import 'package:easy_os_mobile/domain/api/customer_api.dart';
import 'package:easy_os_mobile/routes/app_routes.dart';
import 'package:easy_os_mobile/widgets/form_wrapper.dart';
import 'package:easy_os_mobile/widgets/custom_button.dart';
import 'package:easy_os_mobile/widgets/custom_alert_dialog.dart';
import 'package:easy_os_mobile/widgets/input_field.dart';

class CreateOrder extends StatefulWidget {
  const CreateOrder({super.key});

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _costPriceController = TextEditingController();
  final _servicePriceController = TextEditingController();

  final _customerApi = CustomerApi();

  Future<bool>? _futureSubmit;

  final _phoneMask = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'\d')},
  );
  final _priceMask = MaskTextInputFormatter(
    mask: '#########.##',
    filter: {"#": RegExp(r'\d')},
  );

  Future<bool> _submitOrder() async {
    final customerModel = CustomerModel(
      fullName: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      description: _descriptionController.text.trim(),
      costPrice: _costPriceController.text.trim(),
      servicePrice: _servicePriceController.text.trim(),
    );
    await _customerApi.postUser(customerModel);
    return true;
  }

  Future<void> _showError(String msg) {
    return CustomAlertDialog.show(
      context,
      title: 'Erro',
      content: msg,
      confirmText: 'OK',
      cancelText: '',
    ).then((_) {});
  }

  bool _isNumeric(String s) {
    return double.tryParse(s.replaceAll(',', '.')) != null;
  }

  void _onTapSubmit() {
    if (_futureSubmit != null) return;

    if (_nameController.text.trim().isEmpty) {
      _showError('O nome é obrigatório');
      return;
    }
    if (_phoneController.text.trim().isEmpty) {
      _showError('O telefone é obrigatório');
      return;
    }
    if (!_phoneMask.isFill()) {
      _showError('Telefone inválido');
      return;
    }
    if (_emailController.text.trim().isEmpty) {
      _showError('O email é obrigatório');
      return;
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+$');
    if (!emailRegex.hasMatch(_emailController.text.trim())) {
      _showError('Email inválido');
      return;
    }
    if (_descriptionController.text.trim().isEmpty) {
      _showError('A descrição do problema é obrigatória');
      return;
    }
    if (_costPriceController.text.trim().isEmpty) {
      _showError('O custo do serviço é obrigatório');
      return;
    }
    if (!_isNumeric(_costPriceController.text.trim())) {
      _showError('Custo do serviço deve ser numérico');
      return;
    }
    if (_servicePriceController.text.trim().isEmpty) {
      _showError('O preço do serviço é obrigatório');
      return;
    }
    if (!_isNumeric(_servicePriceController.text.trim())) {
      _showError('Preço do serviço deve ser numérico');
      return;
    }

    setState(() {
      _futureSubmit = _submitOrder();
    });
  }

  @override
  Widget build(BuildContext context) {
    if (_futureSubmit != null) {
      return FutureBuilder<bool>(
        future: _futureSubmit,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const LoadingAnimation(size: 120);
          } else if (snapshot.hasError) {
            return SingleChildScrollView(
              child: FormWrapper(
                child: Column(
                  children: [
                    Text(
                      'Erro ao criar pedido:\n${snapshot.error}',
                      style: const TextStyle(color: Colors.red),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 20),
                    CustomButton(
                      txtBtn: 'Tentar Novamente',
                      onTap: () {
                        setState(() {
                          _futureSubmit = null;
                        });
                      },
                    ),
                  ],
                ),
              ),
            );
          } else {
            WidgetsBinding.instance.addPostFrameCallback((_) {
              Navigator.of(context).pushReplacementNamed(AppRoutes.ordersBody);
            });
            return const SizedBox.shrink();
          }
        },
      );
    }

    return SingleChildScrollView(
      child: FormWrapper(
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              InputField(
                labelTxt: 'Nome Completo',
                controller: _nameController,
              ),
              InputField(
                labelTxt: 'Telefone',
                controller: _phoneController,
                keyboardType: TextInputType.phone,
                inputFormatters: [_phoneMask],
              ),
              InputField(
                labelTxt: 'Email',
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              InputField(
                labelTxt: 'Descrição do problema',
                controller: _descriptionController,
                maxLines: 3,
              ),
              InputField(
                labelTxt: 'Custo do serviço',
                controller: _costPriceController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d,\.]')),
                  _priceMask,
                ],
              ),
              InputField(
                labelTxt: 'Preço do serviço',
                controller: _servicePriceController,
                keyboardType: TextInputType.numberWithOptions(decimal: true),
                inputFormatters: [
                  FilteringTextInputFormatter.allow(RegExp(r'[\d,\.]')),
                  _priceMask,
                ],
              ),
              const SizedBox(height: 20),
              CustomButton(txtBtn: 'Criar', onTap: _onTapSubmit),
              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
