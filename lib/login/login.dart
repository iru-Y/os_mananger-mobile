import 'package:easy_os_mobile/colors/custom_colors.dart';
import 'package:easy_os_mobile/domain/api/jwt_request.dart';
import 'package:easy_os_mobile/domain/secure_storage/secure_storage_service.dart';
import 'package:easy_os_mobile/routes/app_routes.dart';
import 'package:easy_os_mobile/text/custom_sub_title.dart';
import 'package:easy_os_mobile/text/custom_title.dart';
import 'package:easy_os_mobile/widgets/custom_button.dart';
import 'package:easy_os_mobile/widgets/custom_modal.dart';
import 'package:easy_os_mobile/widgets/input_field.dart';
import 'package:flutter/material.dart';
import 'package:logger/logger.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  final Logger logger = Logger();
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final JwtRequest jwtRequest = JwtRequest();
  final SecureStorageService storage = SecureStorageService();

  bool rememberMe = false;

  @override
  void initState() {
    super.initState();
    _loadSavedCredentials();
  }

  Future<void> _loadSavedCredentials() async {
    final savedUser = await storage.getValue('saved_user');
    final savedPass = await storage.getValue('saved_pass');
    if (savedUser != null && savedPass != null) {
      userNameController.text = savedUser;
      passwordController.text = savedPass;
      setState(() => rememberMe = true);
    }
  }

  void login() async {
    final username = userNameController.text.trim();
    final password = passwordController.text;

    try {
      final token = await jwtRequest.getToken(username, password);
      logger.i('Login bem-sucedido — token: $token');

      await storage.saveToken(token);
      if (rememberMe) {
        await storage.saveValue('saved_user', username);
        await storage.saveValue('saved_pass', password);
      } else {
        await storage.deleteValue('saved_user');
        await storage.deleteValue('saved_pass');
      }

      if (!mounted) return;
      Navigator.of(context).pushReplacementNamed(AppRoutes.ordersBody);
    } catch (e, stack) {
      logger.e('Erro no login', error: e, stackTrace: stack);
      if (!mounted) return;
      showDialog(
        context: context,
        builder:
            (_) => AlertDialog(
              title: Text('Erro'),
              content: Text(
                'Erro ao fazer login, verifique suas credenciais e tente novamente.',
              ),
              actions: [
                IconButton(
                  onPressed: () => Navigator.of(context).pop(),
                  icon: Icon(Icons.close),
                ),
              ],
            ),
      );
    }
  }

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
                    obscureText: true,
                    labelTxt: 'Senha',
                    textEditingController: passwordController,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Checkbox(
                        activeColor: CustomColors.btnColor,
                        value: rememberMe,
                        onChanged: (bool? value) {
                          setState(() => rememberMe = value ?? false);
                        },
                      ),
                     CustomSubTitle(title: 'Salvar Login e Senha?'),
                    ],
                  ),
                  CustomButton(txtBtn: 'Entrar', onTap: login),
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
