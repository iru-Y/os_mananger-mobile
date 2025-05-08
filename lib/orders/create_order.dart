import 'package:easy_os_mobile/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:easy_os_mobile/domain/api/customer_api.dart';
import 'package:easy_os_mobile/domain/schema/customer_request.dart';
import 'package:easy_os_mobile/routes/app_routes.dart';
import 'package:easy_os_mobile/widgets/custom_button.dart';
import 'package:easy_os_mobile/widgets/form_wrapper.dart';

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
  bool _isLoading = false;

  Future<void> _postCustomer() async {
    if (_isLoading) return;
    setState(() => _isLoading = true);

    final request = CustomerRequest(
      fullName: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      description: _descriptionController.text.trim(),
      price: _priceController.text.trim(),
    );

    try {
      final created = await _customerApi.postUser(request);
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
      ScaffoldMessenger.of(
        context,
      ).showSnackBar(SnackBar(content: Text('Erro: ${e.toString()}')));
    } finally {
      if (mounted) {
        setState(() => _isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
            CustomButton(
              onTap:
                  _isLoading
                      ? () {}
                      : () {
                        _postCustomer();
                      },
              txtBtn: _isLoading ? 'Enviando...' : 'Criar',
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }
}
