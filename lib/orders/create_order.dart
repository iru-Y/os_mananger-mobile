import 'dart:async';

import 'package:flutter/material.dart';
import 'package:easy_os_mobile/widgets/input_field.dart';
import 'package:easy_os_mobile/widgets/custom_button.dart';
import 'package:easy_os_mobile/widgets/form_wrapper.dart';
import 'package:easy_os_mobile/domain/api/customer_api.dart';
import 'package:easy_os_mobile/domain/schema/customer_request.dart';
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
  final _priceController = TextEditingController();

  final _customerApi = CustomerApi();

  Future<bool>? _futureSubmit;

  Future<bool> _submitOrder() async {
    final req = CustomerRequest(
      fullName: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      description: _descriptionController.text.trim(),
      price: _priceController.text.trim(),
    );

    final created = await _customerApi.postUser(req);
    if (created == null) {
      throw Exception('Falha ao criar ordem');
    }
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
              labelTxt: 'Preço do serviço',
              textEditingController: _priceController,
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
