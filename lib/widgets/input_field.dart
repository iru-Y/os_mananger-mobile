import 'package:easy_os_mobile/colors/custom_colors.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  final String labelTxt;
  final TextEditingController textEditingController;
  const InputField({super.key, required this.labelTxt, required this.textEditingController});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: 10),
        Text(labelTxt, style: TextStyle(fontSize: 16)),
        SizedBox(height: 5),
        TextFormField(
          controller: textEditingController,
          decoration: InputDecoration(
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
          ),
          cursorColor: Colors.white,
        ),
      ],
    );
  }
}
