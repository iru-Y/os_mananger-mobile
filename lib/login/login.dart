import 'package:easy_os_mobile/colors/custom_colors.dart';
import 'package:easy_os_mobile/text/custom_sub_title.dart';
import 'package:easy_os_mobile/text/custom_title.dart';
import 'package:easy_os_mobile/widgets/custom_button.dart';
import 'package:easy_os_mobile/widgets/custom_modal.dart';
import 'package:easy_os_mobile/widgets/input_field.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100),
          CustomTitle(title: 'Bem-vindo'),
          CustomModal(
            widget: Form(
              child: Column(
                children: [
                  InputField(
                    labelTxt: 'Técnico',
                    textEditingController: userNameController,
                  ),
                  InputField(
                    labelTxt: 'Senha',
                    textEditingController: passwordController,
                  ),
                  SizedBox(height: 20),
                  CustomButton(txtBtn: 'Entrar', onTap: () => {}),
                  SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomSubTitle(title: 'Não tem uma conta?'),
                      SizedBox(width: 10),
                      CustomSubTitle(
                        title: 'Cadastre-se',
                        color: CustomColors.registerColor,
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
