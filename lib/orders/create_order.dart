import 'dart:async';

import 'package:easy_os_mobile/domain/model/customer_model.dart';
import 'package:flutter/material.dart';
import 'package:easy_os_mobile/widgets/input_field.dart';
import 'package:easy_os_mobile/widgets/custom_button.dart';
import 'package:easy_os_mobile/widgets/form_wrapper.dart';
import 'package:easy_os_mobile/domain/api/customer_api.dart';
import 'package:easy_os_mobile/routes/app_routes.dart';

class CreateOrder extends StatefulWidget {
  const CreateOrder({super.key});

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _costPriceController = TextEditingController();
  final _servicePriceController = TextEditingController();

  final _customerApi = CustomerApi();

  Future<bool>? _futureSubmit;

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

  void _onTapSubmit() {
    if (_futureSubmit != null) return;
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
          switch (snapshot.connectionState) {
            case ConnectionState.waiting:
              return const Center(child: CircularProgressIndicator());
            default:
              if (snapshot.hasError) {
                return SingleChildScrollView(
                  child: FormWrapper(
                    child: Column(
                      children: [
                        Text(
                          'Erro: ${snapshot.error}',
                          style: const TextStyle(color: Colors.red),
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
                  Navigator.of(
                    context,
                  ).pushReplacementNamed(AppRoutes.ordersBody);
                });
                return const SizedBox.shrink();
              }
          }
        },
      );
    }

    return SingleChildScrollView(
      child: FormWrapper(
        child: Column(
          children: [
            InputField(
              labelTxt: 'Nome Completo',
              textEditingController: _nameController,
            ),
            InputField(
              labelTxt: 'Telefone',
              textEditingController: _phoneController,
            ),
            InputField(
              labelTxt: 'Email',
              textEditingController: _emailController,
            ),
            InputField(
              labelTxt: 'Descrição do problema',
              textEditingController: _descriptionController,
            ),
            InputField(
              labelTxt: 'Custo do serviço',
              textEditingController: _costPriceController,
            ),
            InputField(
              labelTxt: 'Preço do serviço',
              textEditingController: _servicePriceController,
            ),
            const SizedBox(height: 20),
            CustomButton(txtBtn: 'Criar', onTap: _onTapSubmit),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
