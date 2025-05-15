import 'package:easy_os_mobile/colors/custom_colors.dart';
import 'package:flutter/material.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class LoadingAnimation extends StatelessWidget {
  final double size;
  const LoadingAnimation({super.key, required this.size});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: LoadingAnimationWidget.fallingDot(
        color: CustomColors.btnColor,
        size: size,
      ),
    );
  }
}
