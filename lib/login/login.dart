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
        body: Column(
          children: [
            SizedBox(height: 50,),
            CustomTitle(title: 'BEM-VINDO'), 
            Container(
              margin: EdgeInsets.only(top: 20, left: 20, right: 20),
              padding: EdgeInsets.symmetric(vertical: 26, horizontal: 20),
              decoration: BoxDecoration(
                border: Border.all(color: CustomColors.outlineBorder),
                borderRadius: BorderRadius.circular(5),
              color: CustomColors.backgroundFormColor, 
              ),
              child: Column(
                children: [CustomForm()],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
