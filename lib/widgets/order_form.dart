import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:easy_os_mobile/widgets/form_wrapper.dart';
import 'package:easy_os_mobile/widgets/input_field.dart';
import 'package:easy_os_mobile/widgets/custom_button.dart';

class OrderForm extends StatelessWidget {
  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController email;
  final TextEditingController description;
  final TextEditingController cost;
  final TextEditingController service;
  final MaskTextInputFormatter phoneMask;
  final VoidCallback onSubmit;

  const OrderForm({
    super.key,
    required this.name,
    required this.phone,
    required this.email,
    required this.description,
    required this.cost,
    required this.service,
    required this.phoneMask,
    required this.onSubmit,
  });

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: FormWrapper(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            InputField(labelTxt: 'Nome Completo', controller: name),
            InputField(
              labelTxt: 'Telefone',
              controller: phone,
              keyboardType: TextInputType.phone,
              inputFormatters: [phoneMask],
            ),
            InputField(
              labelTxt: 'Email',
              controller: email,
              keyboardType: TextInputType.emailAddress,
            ),
            InputField(
              labelTxt: 'Descrição',
              controller: description,
              maxLines: 3,
            ),
            InputField(
              labelTxt: 'Custo do serviço',
              controller: cost,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
            InputField(
              labelTxt: 'Valor do serviço',
              controller: service,
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
            ),
            const SizedBox(height: 20),
            CustomButton(txtBtn: 'Salvar', onTap: onSubmit),
          ],
        ),
      ),
    );
  }
}
