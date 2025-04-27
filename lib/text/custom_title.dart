import 'package:flutter/material.dart';

class CustomTitle extends StatelessWidget {
  final String title;

  const CustomTitle({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Work_Sans',
        fontSize: 36,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
