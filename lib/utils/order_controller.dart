import 'package:flutter_masked_text2/flutter_masked_text2.dart';
import 'package:flutter/material.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:easy_os_mobile/domain/model/customer_model.dart';

class OrderControllers {
  final TextEditingController name;
  final TextEditingController phone;
  final TextEditingController email;
  final TextEditingController description;
  final MoneyMaskedTextController cost;
  final MoneyMaskedTextController service;

  static final phoneMask = MaskTextInputFormatter(
    mask: '(##) #####-####',
    filter: {"#": RegExp(r'\d')},
  );

  OrderControllers({CustomerModel? model})
    : name = TextEditingController(text: model?.fullName),
      phone = TextEditingController(
        text: model != null ? phoneMask.maskText(model.phone ?? '') : '',
      ),
      email = TextEditingController(text: model?.email),
      description = TextEditingController(text: model?.description),
      cost = MoneyMaskedTextController(
        decimalSeparator: '.',
        thousandSeparator: '',
        precision: 2,
        initialValue: double.tryParse(model?.costPrice ?? '') ?? 0,
      ),
      service = MoneyMaskedTextController(
        decimalSeparator: '.',
        thousandSeparator: '',
        precision: 2,
        initialValue: double.tryParse(model?.servicePrice ?? '') ?? 0,
      );

  Map<String, TextEditingController> asMap() => {
    'name': name,
    'phone': phone,
    'email': email,
    'desc': description,
    'cost': cost,
    'service': service,
  };
}
