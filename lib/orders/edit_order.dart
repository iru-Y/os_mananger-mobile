import 'package:easy_os_mobile/domain/api/customer_api.dart';
import 'package:easy_os_mobile/domain/model/customer_model.dart';
import 'package:easy_os_mobile/widgets/custom_button.dart';
import 'package:easy_os_mobile/widgets/form_wrapper.dart';
import 'package:easy_os_mobile/widgets/input_field.dart';
import 'package:easy_os_mobile/widgets/custom_alert_dialog.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:flutter_masked_text2/flutter_masked_text2.dart';

class EditOrder extends StatefulWidget {
  final CustomerModel customer;

  const EditOrder({super.key, required this.customer});

  @override
  State<EditOrder> createState() => _EditOrderState();
}

class _EditOrderState extends State<EditOrder> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _descriptionController = TextEditingController();
  late MoneyMaskedTextController _servicePriceController;
  late MoneyMaskedTextController _costPriceController;

  final CustomerApi _customerApi = CustomerApi();
  Future<bool>? _futureUpdate;

  final _phoneMask = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'\d')},
  );

  @override
  void initState() {
    super.initState();

    _nameController.text = widget.customer.fullName ?? '';
    _phoneController.text = _phoneMask.maskText(widget.customer.phone ?? '');
    _emailController.text = widget.customer.email ?? '';
    _descriptionController.text = widget.customer.description ?? '';

    double serviceValue =
        double.tryParse(widget.customer.servicePrice ?? '') ?? 0;
    double costValue = double.tryParse(widget.customer.costPrice ?? '') ?? 0;

    _servicePriceController = MoneyMaskedTextController(
      decimalSeparator: '.',
      thousandSeparator: '',
      precision: 2,
      initialValue: serviceValue,
    );
    _costPriceController = MoneyMaskedTextController(
      decimalSeparator: '.',
      thousandSeparator: '',
      precision: 2,
      initialValue: costValue,
    );
  }

  bool _isNumeric(String s) => double.tryParse(s.replaceAll(',', '.')) != null;

  Future<void> _showError(String msg) async {
    await CustomAlertDialog.show(
      context,
      title: 'Erro',
      content: msg,
      confirmText: 'OK',
      cancelText: '',
      isError: true,
    );
  }

  Future<bool> _updateOrder() async {
    final customerModel = CustomerModel(
      fullName: _nameController.text.trim(),
      phone: _phoneController.text.trim(),
      email: _emailController.text.trim(),
      description: _descriptionController.text.trim(),
      servicePrice: _servicePriceController.text.replaceAll(',', '.').trim(),
      costPrice: _costPriceController.text.replaceAll(',', '.').trim(),
    );
    final patched = await _customerApi.patchCustomer(
      widget.customer.id!,
      customerModel,
    );
    return patched != null;
  }

  void _onTapUpdate() {
    if (_futureUpdate != null) return;

    if (_nameController.text.trim().isEmpty) {
      _showError('O nome é obrigatório');
      return;
    }
    if (_phoneController.text.trim().isEmpty) {
      _showError('O telefone é obrigatório');
      return;
    }
    final phoneRegex = RegExp(r'^\(\d{2}\) \d{5}-\d{4}$');
    if (!phoneRegex.hasMatch(_phoneController.text.trim())) {
      _showError('Telefone inválido');
      return;
    }

    if (_emailController.text.trim().isEmpty) {
      _showError('O email é obrigatório');
      return;
    }
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+');
    if (!emailRegex.hasMatch(_emailController.text.trim())) {
      _showError('Email inválido');
      return;
    }
    if (_descriptionController.text.trim().isEmpty) {
      _showError('A descrição do problema é obrigatória');
      return;
    }
    if (_costPriceController.numberValue == 0) {
      _showError('O custo do serviço é obrigatório');
      return;
    }
    if (!_isNumeric(_costPriceController.text.trim())) {
      _showError('Custo do serviço deve ser numérico');
      return;
    }
    if (_servicePriceController.numberValue == 0) {
      _showError('O preço do serviço é obrigatório');
      return;
    }
    if (!_isNumeric(_servicePriceController.text.trim())) {
      _showError('Preço do serviço deve ser numérico');
      return;
    }

    setState(() {
      _futureUpdate = _updateOrder();
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: _futureUpdate,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }
        if (snapshot.hasError) {
          return Center(
            child: Text(
              'Erro: \${snapshot.error}',
              style: const TextStyle(color: Colors.red),
            ),
          );
        }
        if (snapshot.hasData && snapshot.data == true) {
          WidgetsBinding.instance.addPostFrameCallback((_) {
            Navigator.of(context).pop(true);
          });
          return const SizedBox.shrink();
        }

        return SingleChildScrollView(
          child: FormWrapper(
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
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
                    labelTxt: 'Descrição',
                    controller: _descriptionController,
                    maxLines: 3,
                  ),
                  InputField(
                    labelTxt: 'Custo do serviço',
                    controller: _costPriceController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                  InputField(
                    labelTxt: 'Valor do serviço',
                    controller: _servicePriceController,
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                  ),
                  const SizedBox(height: 20),
                  CustomButton(
                    txtBtn: 'Salvar Alterações',
                    onTap: _onTapUpdate,
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
