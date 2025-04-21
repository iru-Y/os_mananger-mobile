import 'package:easy_os_mobile/colors/custom_colors.dart';
import 'package:easy_os_mobile/form/custom_form.dart';
import 'package:easy_os_mobile/text/title.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Container(
          margin: EdgeInsets.only(top: 100),
          height: 300,
          decoration: BoxDecoration(
            border: Border.all(color: CustomColors.outlineBorder),
            borderRadius: BorderRadius.circular(5),
          color: CustomColors.backgroundFormColor, 
          ),
          child: Column(
            children: [CustomTitle(title: 'BEM-VINDO'), CustomForm()],
          ),
        ),
      ),
    );
  }
}
