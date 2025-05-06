import 'package:flutter/material.dart';
import 'package:easy_os_mobile/domain/api/customer_api.dart';
import 'package:easy_os_mobile/domain/schema/customer_request.dart';
import 'package:easy_os_mobile/routes/app_routes.dart';
import 'package:easy_os_mobile/text/custom_title.dart';
import 'package:easy_os_mobile/widgets/custom_button.dart';
import 'package:easy_os_mobile/widgets/form_wrapper.dart';
import 'package:easy_os_mobile/widgets/input_field.dart';

class CreateOrder extends StatefulWidget {
  const CreateOrder({super.key});

  @override
  State<CreateOrder> createState() => _CreateOrderState();
}

class _CreateOrderState extends State<CreateOrder> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _phoneController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _descriptionController = TextEditingController();
  final TextEditingController _priceController = TextEditingController();

  final CustomerApi _customerApi = CustomerApi();
  bool _isLoading = false;

  Future<void> _postCustomer() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    final customerRequest = CustomerRequest(
      fullName: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      description: _descriptionController.text.trim(),
      price: _priceController.text.trim(),
    );

    try {
      final created = await _customerApi.postUser(customerRequest);
      if (created != null) {
        if (!mounted) return;
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Ordem criada com sucesso')),
        );
        Navigator.of(context).pushNamed(AppRoutes.ordersBody);
      } else {
        throw Exception('Falha ao criar ordem');
      }
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Erro: ${e.toString()}')),
      );
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(vertical: 30),
          child: Column(
            children: [
              const CustomTitle(title: 'Nova Ordem de Serviço'),
              FormWrapper(
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
                    CustomButton(
                      onTap: _postCustomer,
                      txtBtn: _isLoading ? 'Enviando...' : 'Criar',
                      enabled: !_isLoading,
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
