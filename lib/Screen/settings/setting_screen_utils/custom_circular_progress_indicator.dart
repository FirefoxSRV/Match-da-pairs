import 'package:flutter/material.dart';



Future<void> showLoadingDialog(BuildContext context, String text) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: false,
    builder: (BuildContext dialogContext) {
      return AlertDialog(
        content: Row(
          children: [
            CircularProgressIndicator(),
            SizedBox(width: 24),
            Text(text),
          ],
        ),
      );
    },
  );
}
