import 'package:flutter/material.dart';

class Title extends StatelessWidget {
  final String title = '';
  
  const Title({super.key});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(fontFamily: 'Work_Sans', fontSize: 36));
  }
}
