import 'package:flutter/material.dart';

class CustomModalBottomSheet extends StatelessWidget {
  final Widget child;
  final bool isDismissible;
  final Function? onDismiss;

  const CustomModalBottomSheet({
    super.key,
    required this.child, 
    this.isDismissible = true,
    this.onDismiss,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
       
        if (isDismissible) {
          Navigator.of(context).pop();
        }
      },
      child: Material(
        color: Colors.transparent,
        child: GestureDetector(
          onTap: () {},
          child: Container(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).viewInsets.bottom + 16,
              left: 16,
              right: 16,
              top: 32,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}
