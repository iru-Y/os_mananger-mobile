import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String labelTxt;
  const InputField({super.key, required this.labelTxt});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            labelTxt, style: TextStyle(
            fontSize: 24,
          ),),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
