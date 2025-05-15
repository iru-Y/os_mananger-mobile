import 'package:easy_os_mobile/colors/custom_colors.dart';
import 'package:easy_os_mobile/domain/api/jwt_request.dart';
import 'package:easy_os_mobile/domain/secure_storage/secure_storage_service.dart';
import 'package:easy_os_mobile/routes/app_routes.dart';
import 'package:easy_os_mobile/text/custom_sub_title.dart';
import 'package:easy_os_mobile/text/custom_title.dart';
import 'package:easy_os_mobile/widgets/custom_alert_dialog.dart';
import 'package:easy_os_mobile/widgets/custom_button.dart';
import 'package:easy_os_mobile/widgets/form_wrapper.dart';
import 'package:easy_os_mobile/widgets/input_field.dart';
import 'package:easy_os_mobile/widgets/loading_animation.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';
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
  Future<void>? loginFuture;

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

  Future<void> doLogin() async {
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
            (_) => CustomAlertDialog(
              title: 'Erro ao fazer login',
              content: 'Verifique se o login e senha estão corretos',
              isError: true,
            ),
      );
    }
  }

  void login() {
    setState(() {
      loginFuture = doLogin();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          const SizedBox(height: 100),
          const CustomTitle(title: 'Bem-vindo'),
          FormWrapper(
            child: FutureBuilder<void>(
              future: loginFuture,
              builder: (context, snapshot) {
                Widget actionWidget;

                if (snapshot.connectionState == ConnectionState.waiting) {
                  actionWidget = const LoadingAnimation(size: 40);
                } else {
                  actionWidget = CustomButton(txtBtn: 'Entrar', onTap: login);
                }

                return Form(
                  child: Column(
                    children: [
                      InputField(
                        labelTxt: 'Técnico',
                        controller: userNameController,
                      ),
                      InputField(
                        obscureText: true,
                        labelTxt: 'Senha',
                        controller: passwordController,
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
                          const CustomSubTitle(title: 'Salvar Login e Senha?'),
                        ],
                      ),
                      actionWidget,
                      const SizedBox(height: 10),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const CustomSubTitle(title: 'Não tem uma conta?'),
                          const SizedBox(width: 10),
                          CustomSubTitle(
                            title: 'Cadastre-se',
                            color: CustomColors.registerColor,
                          ),
                        ],
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
