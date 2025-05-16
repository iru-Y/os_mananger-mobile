import 'package:flutter/material.dart';
import 'package:easy_os_mobile/colors/custom_colors.dart';
import 'package:awesome_dialog/awesome_dialog.dart';
import 'dart:async';

class CustomAlertDialog {
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String content,
    String confirmText = 'Confirmar',
    String cancelText = 'Cancelar',
    bool isError = false,
  }) {
    final completer = Completer<bool?>();

    AwesomeDialog(
      context: context,
      dialogType: isError ? DialogType.error : DialogType.success,
      animType: AnimType.scale,
      headerAnimationLoop: false,
      title: title,
      desc: content,
      borderSide: BorderSide(color: CustomColors.outlineBorder, width: 2),
      dialogBackgroundColor: CustomColors.backgroundFormColor,
      titleTextStyle: const TextStyle(
        color: Colors.white,
        fontSize: 24,
        fontWeight: FontWeight.bold,
      ),
      descTextStyle: const TextStyle(color: Colors.white70, fontSize: 18),
      dialogBorderRadius: BorderRadius.circular(5),

      btnCancel:
          isError
              ? null
              : TextButton.icon(
                onPressed: () {
                  completer.complete(false);
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.cancel_outlined, color: Colors.grey),
                label: Text(
                  cancelText,
                  style: const TextStyle(color: Colors.grey),
                ),
                style: TextButton.styleFrom(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4),
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),
              ),

      btnOk: ElevatedButton.icon(
        onPressed: () {
          completer.complete(true);
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.check_circle_outline, color: Colors.white),
        label: Text(confirmText, style: const TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: CustomColors.registerColor,
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
        ),
      ),
    ).show();

    return completer.future;
  }
}
