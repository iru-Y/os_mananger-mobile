import 'package:easy_os_mobile/colors/custom_colors.dart';
import 'package:flutter/material.dart';

class FormWrapper extends StatelessWidget {
  final Widget widget;
  const FormWrapper({super.key, required this.widget});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: 20, left: 20, right: 20),
      padding: EdgeInsets.symmetric(vertical: 26, horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: CustomColors.outlineBorder),
        borderRadius: BorderRadius.circular(5),
        color: CustomColors.backgroundFormColor,
      ),
      child: Column(children: [widget]),
    );
  }
}
