import 'package:flutter/material.dart';
import 'package:easy_os_mobile/colors/custom_colors.dart';

class CustomAlertDialog extends StatelessWidget {
  final String title;
  final String content;
  final String confirmText;
  final String cancelText;

  const CustomAlertDialog({
    super.key,
    required this.title,
    required this.content,
    this.confirmText = 'Confirmar',
    this.cancelText = 'Cancelar',
  });

  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String content,
    String confirmText = 'Confirmar',
    String cancelText = 'Cancelar',
  }) {
    return showDialog<bool>(
      context: context,
      builder:
          (context) => CustomAlertDialog(
            title: title,
            content: content,
            confirmText: confirmText,
            cancelText: cancelText,
          ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: CustomColors.backgroundFormColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
        side: BorderSide(color: CustomColors.outlineBorder),
      ),
      title: Text(
        title,
        style: const TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.bold,
        ),
      ),
      content: Text(content, style: const TextStyle(color: Colors.white70)),
      actions: [
        if (cancelText.isNotEmpty)
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            style: TextButton.styleFrom(foregroundColor: CustomColors.btnColor),
            child: Text(cancelText),
          ),
        TextButton(
          onPressed: () => Navigator.pop(context, true),
          style: TextButton.styleFrom(
            foregroundColor: CustomColors.registerColor,
          ),
          child: Text(confirmText),
        ),
      ],
    );
  }
}
