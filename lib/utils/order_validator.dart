import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';

class OrderValidator {
  static String? validateName(String v) {
    return v.trim().isEmpty ? 'O nome é obrigatório' : null;
  }

  static String? validatePhone(String v, MaskTextInputFormatter mask) {
    if (v.trim().isEmpty) return 'O telefone é obrigatório';
    if (!mask.isFill()) return 'Telefone inválido';
    return null;
  }

  static String? validateEmail(String v) {
    if (v.trim().isEmpty) return 'O email é obrigatório';
    final emailRegex = RegExp(r'^[^@\s]+@[^@\s]+\.[^@\s]+\$');
    return emailRegex.hasMatch(v.trim()) ? null : 'Email inválido';
  }

  static String? validateDescription(String v) {
    return v.trim().isEmpty ? 'A descrição é obrigatória' : null;
  }

  static String? validateCost(double val) {
    return val <= 0 ? 'O custo do serviço é obrigatório' : null;
  }

  static String? validateService(double val) {
    return val <= 0 ? 'O preço do serviço é obrigatório' : null;
  }
}