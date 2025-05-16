import 'package:flutter/material.dart';
import 'package:easy_os_mobile/colors/custom_colors.dart';
import 'package:awesome_dialog/awesome_dialog.dart';

class CustomAlertDialog {
  static Future<bool?> show(
    BuildContext context, {
    required String title,
    required String content,
    String confirmText = 'Confirmar',
    String cancelText = 'Cancelar',
    bool isError = false,
  }) async {
    bool? confirmed;

    await AwesomeDialog(
      context: context,
      dialogType: isError ? DialogType.error : DialogType.warning,
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
      btnCancelText: cancelText,
      btnOkText: confirmText,

      btnCancel:
          isError
              ? TextButton.icon(
                onPressed: () {
                  confirmed = false;
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.cancel_outlined, color: Colors.grey),
                label: Text(
                  cancelText,
                  style: const TextStyle(color: Colors.grey),
                ),
                style: TextButton.styleFrom(
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(4), // Menos arredondado
                    side: const BorderSide(color: Colors.grey),
                  ),
                ),
              )
              : SizedBox(),
      btnOk: ElevatedButton.icon(
        onPressed: () {
          confirmed = true;
          Navigator.of(context).pop();
        },
        icon: const Icon(Icons.check_circle_outline, color: Colors.white),
        label: Text(confirmText, style: const TextStyle(color: Colors.white)),
        style: ElevatedButton.styleFrom(
          backgroundColor: isError ? Colors.red : CustomColors.registerColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(4), // Menos arredondado
          ),
        ),
      ),
      btnCancelOnPress: () {
        confirmed = false;
      },
      btnOkOnPress: () {
        confirmed = true;
      },
      btnCancelColor: Colors.grey,
      btnOkColor: isError ? Colors.red : CustomColors.registerColor,
    ).show();

    return confirmed;
  }
}
