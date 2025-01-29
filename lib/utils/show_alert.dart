import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:flutter/material.dart';

void showAwesomeDialog(BuildContext context, String message, DialogType type) {
  AwesomeDialog(
    padding: EdgeInsets.all(16),
    context: context,
    dialogType: type,
    headerAnimationLoop: false,
    animType: AnimType.topSlide,
    showCloseIcon: true,
    closeIcon: const Icon(Icons.close_fullscreen_outlined),
    title: 'Error',
    desc: message,
    btnCancelOnPress: () {},
    onDismissCallback: (type) {
      debugPrint('Dialog Dismiss from callback $type');
    },
  ).show();
}
