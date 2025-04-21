import 'package:easy_os_mobile/widgets/input_field.dart';
import 'package:flutter/material.dart';

class CustomForm extends StatelessWidget {
  const CustomForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          InputField(labelTxt: 'Nome Completo'),
          InputField(labelTxt: 'Telefone'),
          InputField(labelTxt: 'Email'),
          InputField(labelTxt: 'Endereço'),
          InputField(labelTxt: 'Descrição do problema'),
        ],
      ),
    );
  }
}
