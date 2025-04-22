import 'package:easy_os_mobile/colors/custom_colors.dart';
import 'package:easy_os_mobile/form/custom_form.dart';
import 'package:easy_os_mobile/text/title.dart';
import 'package:easy_os_mobile/widgets/custom_modal.dart';
import 'package:flutter/material.dart';

class Login extends StatelessWidget {
  const Login({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(
            children: [
              SizedBox(height: 50),
              CustomTitle(title: 'BEM-VINDO'),
              CustomModal(widget: CustomForm(),),
            ],
          ),
        ),
      ),
    );
  }

 
}
