import 'package:easy_os_mobile/colors/custom_colors.dart';
import 'package:flutter/material.dart';

class FormWrapper extends StatelessWidget {
  final Widget child;
  const FormWrapper({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      child: Card(
        borderOnForeground: true,
        elevation: 10,
        shadowColor: Color.fromRGBO(0, 0, 0, 0.4),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5),
          side: BorderSide(color: CustomColors.outlineBorder),
        ),
        color: CustomColors.backgroundFormColor,
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 26, horizontal: 20),
          child: child,
        ),
      ),
    );
  }
}
