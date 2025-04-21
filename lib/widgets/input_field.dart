import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: TextFormField(
            decoration: InputDecoration(
              labelText: 'Nome Completo',
              border: OutlineInputBorder(borderRadius: BorderRadius.circular(5))
               ),
          ),
    );
  }
}