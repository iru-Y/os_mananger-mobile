import 'package:flutter/material.dart';

class CustomSubTitle extends StatelessWidget {
  final String title;
  final Color? color;
  const CustomSubTitle({super.key, required this.title, this.color});

  @override
  Widget build(BuildContext context) {
    return Text(
      title,
      style: TextStyle(
        fontFamily: 'Mona_Sans',
        fontSize: 16,
        color: color
      ),
    );
  }
}
