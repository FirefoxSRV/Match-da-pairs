import 'package:flutter/material.dart';



Future<void> showLoadingDialog(BuildContext context, String text) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        content: Row(
          children: [
            const CircularProgressIndicator(),
            const SizedBox(width: 24),
            Text(text),
          ],
        ),
      );
    },
  );
}
