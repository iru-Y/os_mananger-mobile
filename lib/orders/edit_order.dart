import 'package:easy_os_mobile/colors/custom_colors.dart';
import 'package:easy_os_mobile/domain/api/customer_api.dart';
import 'package:easy_os_mobile/domain/model/customer_model.dart';
import 'package:easy_os_mobile/widgets/form_wrapper.dart';
import 'package:easy_os_mobile/widgets/input_field.dart';
import 'package:flutter/material.dart';

class EditOrder extends StatefulWidget {
  final CustomerModel customer;

  const EditOrder({super.key, required this.customer});

  @override
  State<EditOrder> createState() => _EditOrderState();
}

class _EditOrderState extends State<EditOrder> {
  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _descriptionController = TextEditingController();
  final _priceController = TextEditingController();

  final CustomerApi _customerApi = CustomerApi();
  Future<bool>? _futureUpdate;

  @override
  void initState() {
    super.initState();
    _nameController.text = widget.customer.fullName ?? '';
    _phoneController.text = widget.customer.phone ?? '';
    _emailController.text = widget.customer.email ?? '';
    _descriptionController.text = widget.customer.description ?? '';
    _priceController.text = widget.customer.costPrice ?? '';
    _priceController.text = widget.customer.servicePrice ?? '';
  }

  Future<bool> _updateOrder() async {
    final updates = {
      "fullName": _nameController.text.trim(),
      "phone": _phoneController.text.trim(),
      "email": _emailController.text.trim(),
      "description": _descriptionController.text.trim(),
      "price": _priceController.text.trim(),
    };

    return await _customerApi.patchCustomer(widget.customer.id!, updates) !=
        null;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _futureUpdate,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Text(
              'Erro: ${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (snapshot.hasData && snapshot.data == true) {
          Navigator.of(context).pop();
          return const SizedBox.shrink();
        }

        return SingleChildScrollView(
          child: FormWrapper(
            child: Column(
              mainAxisSize: MainAxisSize.min,
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
                  labelTxt: 'Descrição',
                  textEditingController: _descriptionController,
                ),
                InputField(
                  labelTxt: 'Preço',
                  textEditingController: _priceController,
                ),
                const SizedBox(height: 20),
                ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: CustomColors.btnColor,
                  ),
                  onPressed: () {
                    setState(() {
                      _futureUpdate = _updateOrder();
                    });
                  },
                  child: const Text('Salvar Alterações'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
