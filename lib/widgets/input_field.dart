import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String labelTxt;
  const InputField({super.key, required this.labelTxt});

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10,),
          Text(
            labelTxt, style: TextStyle(
            fontSize: 16,
          ),),
          SizedBox(height: 5,),
          TextFormField(
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(5),
              ),
            ),
          ),
        ],
      );
  }
}
