import 'package:easy_os_mobile/colors/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputField extends StatelessWidget {
  final String labelTxt;
  final TextEditingController controller;
  final bool obscureText;
  final TextInputType? keyboardType;
  final List<TextInputFormatter>? inputFormatters;
  final String? Function(String?)? validator;
  final int maxLines;

  const InputField({
    super.key,
    required this.labelTxt,
    required this.controller,
    this.obscureText = false,
    this.keyboardType,
    this.inputFormatters,
    this.validator,
    this.maxLines = 1,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelTxt,
            style: const TextStyle(fontSize: 16, color: Colors.white70),
          ),
          const SizedBox(height: 5),
          TextFormField(
            controller: controller,
            obscureText: obscureText,
            keyboardType: keyboardType,
            inputFormatters: inputFormatters,
            validator: validator,
            maxLines: maxLines,
            decoration: InputDecoration(
              hoverColor: CustomColors.btnColor,
              focusColor: CustomColors.btnColor,
              contentPadding: const EdgeInsets.symmetric(
                vertical: 12,
                horizontal: 12,
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: CustomColors.outlineBorder,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                  color: CustomColors.outlineBorder,
                  width: 2,
                ),
                borderRadius: BorderRadius.circular(5),
              ),
              errorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.red, width: 2),
                borderRadius: BorderRadius.circular(5),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderSide: const BorderSide(color: Colors.redAccent, width: 2),
                borderRadius: BorderRadius.circular(5),
              ),
              errorStyle: const TextStyle(
                color: Colors.redAccent,
                fontSize: 12,
              ),
            ),
            cursorColor: Colors.white,
            style: const TextStyle(color: Colors.white),
          ),
        ],
      ),
    );
  }
}
